class StudentsController < ApplicationController
    # before_action :authenticate_secretary!, only: [:secretary_view]
    before_action :require_login
    def index
      @students = if params[:query].present?
                    Student.search(params[:query])
                  else
                    Student.all
                  end
  
      @students = @students.order(sort_column + " " + sort_direction)
    end
  
    def new
      @student = Student.new
    end
  
    def create
      @student = Student.find_by(email: student_params[:email])
      #sign_in_date = Date.today.beginning_of_day
      #added this
      @event = Event.find_by(date: DateTime.current.beginning_of_day)
      sign_in_date = Time.current
      #
      
      if @student 
        if find_student_attendance(@student, @event)
          redirect_to new_student_path, alert: "You have already signed in for this event."
        else
          increment_attendance_points(@student)
          update_student_info(@student, student_params)
          record_event_attendance(@student, @event, sign_in_date)
          redirect_to new_student_path, notice: "Student profile updated successfully."
        end
      else
        @student = Student.new(student_params)
        @student.attendance_points = 1
  
        if @student.save
          record_event_attendance(@student, @event, sign_in_date)
          redirect_to new_student_path, notice: "Student profile created successfully."
        else
          render :new
        end
      end
    end

    def find_student_attendance(student, event)
      EventAttendance.exists?(student: student, event: event)
    end

    def increment_attendance_points(student)
      student.attendance_points += 1
      student.save
    end

    def update_student_info(student, params)
      student.name = params[:name]
      student.year = params[:year]
      student.major = params[:major]
      student.save
    end

    def record_event_attendance(student, event, sign_in_date)
      EventAttendance.create(student: student, event: event, attended_on: sign_in_date)
    end
  
    def attendance
        @student = Student.find(params[:id])
        @events_attended = @student.events
    #   if @student
    #     @student.increment(:attendance_points)
    #     @student.events_attended = (@student.events_attended || []) << params[:event]
    #     @student.save
    #     render json: @student
    #   else
    #     @student = Student.new(name: params[:name], year: params[:year], email: params[:email], attendance_points: 1, events_attended: [params[:event]])
    #     if @student.save
    #       render json: @student, status: :created
    #     else
    #       render json: @student.errors, status: :unprocessable_entity
    #     end
    #   end
    end
  
    def secretary_view
      @students = Student.all
    end
  
    private

  def sort_column
    %w[name year email major attendance_points].include?(params[:sort]) ? params[:sort] : "major"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end
  
    def student_params
      params.require(:student).permit(:name, :year, :email, :major, :id)
    end
  
    def authenticate_secretary!
      authenticate_or_request_with_http_basic do |username, password|
        username == 'secretary' && password == 'secret_password'
      end
    end
  end
  
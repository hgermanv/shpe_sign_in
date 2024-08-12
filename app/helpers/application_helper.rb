module ApplicationHelper
    def sortable(column, title = nil)
        title ||= column.titleize
        direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
        link_to title, { sort: column, direction: direction }
      end
    
      def sort_column
        %w[name year email major attendance_points].include?(params[:sort]) ? params[:sort] : "major"
      end
    
      def sort_direction
        %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
      end
end

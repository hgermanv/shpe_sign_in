class CreateStudents < ActiveRecord::Migration[7.1]
  def change
    create_table :students do |t|
      t.string :name
      t.string :year
      t.string :email
      t.integer :attendance_points
      t.text :events_attended

      t.timestamps
    end
  end
end

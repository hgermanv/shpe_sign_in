class AddMajorToStudents < ActiveRecord::Migration[7.1]
  def change
    add_column :students, :major, :string
  end
end

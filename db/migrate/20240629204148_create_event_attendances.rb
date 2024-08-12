class CreateEventAttendances < ActiveRecord::Migration[7.1]
  def change
    create_table :event_attendances do |t|
      t.references :student, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true
      t.datetime :attended_on

      t.timestamps
    end
  end
end

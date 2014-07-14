class CreateNotificationsTable < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
    	t.integer :teacher_id
    	t.string :semester
    	t.string :comment
    	t.timestamps
    end
  end
end

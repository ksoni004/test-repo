class CreateCoursesTable < ActiveRecord::Migration
  def change
    create_table :courses do |t|
    	t.integer :teacher_id
    	t.string :course_name
    end
  end
end

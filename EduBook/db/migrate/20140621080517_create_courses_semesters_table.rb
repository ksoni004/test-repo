class CreateCoursesSemestersTable < ActiveRecord::Migration
  def change
    create_table :courses_semesters, :id => false do |t|
    	t.integer :course_id
    	t.integer :semester_id
    end
    #add_index :semesters_users, [:semester_id, :user_id]
    #add_index :semesters_users, :user_id
  end
end

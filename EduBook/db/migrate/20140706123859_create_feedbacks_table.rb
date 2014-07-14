class CreateFeedbacksTable < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
        t.integer :teacher_id
        t.integer :student_id
    	t.integer :ui
    	t.integer :simplicity
    	t.integer :performance
    	t.integer :content_quality
    	t.integer :background
    	t.integer :navigation
    	t.integer :links
    	t.integer :color_choices
    	t.integer :graphics
    	t.integer :spelling_and_grammar
        t.float :average 
    end
  end
end

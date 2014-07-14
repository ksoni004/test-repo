class CreateDocumentsTable < ActiveRecord::Migration
  def change
    create_table :documents do |t|
    	t.integer :course_id
    	t.integer :counter, :default => 0
    	t.text :comment
    	t.timestamps
    end
  end
end

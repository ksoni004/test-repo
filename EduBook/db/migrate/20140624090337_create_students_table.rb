class CreateStudentsTable < ActiveRecord::Migration
  def change
    create_table :students do |t|
    	t.integer :semester_id
    	t.string :email
    	t.string :password
    	t.string :name
    	t.string :surname
    	
    end
  end
end

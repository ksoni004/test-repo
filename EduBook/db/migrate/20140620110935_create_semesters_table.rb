class CreateSemestersTable < ActiveRecord::Migration
  def change
    create_table :semesters do |t|
    	t.string :year
    	t.string :branch
    	t.string :semester_type
    	t.timestamps
    end
  end
end

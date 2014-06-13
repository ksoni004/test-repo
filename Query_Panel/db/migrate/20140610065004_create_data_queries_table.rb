class CreateDataQueriesTable < ActiveRecord::Migration
  def change
    create_table :data_queries do |t|
    	t.string :name
    	t.string :restaurant_name
    	t.string :comment
    	t.timestamps
    	t.datetime :follow_up
    	t.string :status, :default => 'pending'
    end
  end
end

class CreateActionLogsTable < ActiveRecord::Migration
  def up
  	create_table :action_logs do |t|
    	t.integer :data_query_id
    	t.string :username
    	t.string :comment
    	t.timestamps
    end
  end

  def down
  	drop_table :action_logs
  end
end

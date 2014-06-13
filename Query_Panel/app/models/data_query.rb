class DataQuery < ActiveRecord::Base
	has_many :action_logs

	def self.generate_query(name, restaurant_name, comment)
		DataQuery.create(:name=>name, :restaurant_name=>restaurant_name, :comment=>comment)
	end
end
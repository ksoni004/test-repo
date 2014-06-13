class QueriesController < ApplicationController

	def generate_query
		render 'query/generate_query'

	end

	def query_generated
		DataQuery.generate_query(params[:name], params[:restaurant_name], params[:comment])
		redirect_to :back
	end

	def resolve_query
		@queries = DataQuery.where("status = ? and (follow_up < ? or follow_up is null)", "pending", Time.zone.now.midnight + 24.hours)
		render 'query/resolve_query', :layout => 'main'
	end

	def query_table
		@queries = DataQuery.where("status = ? and (follow_up < ? or follow_up is null)", "pending", Time.zone.now.midnight + 24.hours)
		render 'query/_table', :layout => false
	end

	def close
		a = ActionLog.new
		a.data_query_id = params[:query_id]
		a.username = params[:username]
		a.comment = params[:comment]
		a.save
		b = DataQuery.find(a.data_query_id)
		b.status = 'close'
		b.save
		redirect_to :back
	end

	def follow_up
		a = ActionLog.new
		a.data_query_id = params[:query_id]
		a.username = params[:username]
		a.comment = params[:comment]
		a.save
		b = DataQuery.find(a.data_query_id)
		b.follow_up = params[:follow_up]
		b.status = 'pending'
		b.save
		redirect_to :back
	end
end

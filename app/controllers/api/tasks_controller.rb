class Api::TasksController < ApplicationController

	def index
		render json: current_user.lists.friendly.find(params[:list_id]).find(params[:id])
	end

	def create
		render json: Task.create!(task_params)
	end

	def update
		task = current_user.lists.friendly.find(params[:list_id]).find(params[:id])
		task.update!(task_params)
		render json: task
	end
	
	def destroy
		task = current_user.lists.friendly.find(params[:list_id]).find(params[:id])
		task.destroy!
		head 200
	end

	private
	def task_params
		params.require(:task).permit(:title, :description, :date, :list_id)
	end
end
class Api::TasksController < ApplicationController
	before_action :authenticate_user!

	def index
		render json: current_user.tasks
	end

	def create
		render json: Task.create!(task_params)
	end

	def update
		if owner
			task.update!(task_params)
			render json: task
		else
			head 401
		end
	end

	def destroy
		task.destroy!
		head 200
	end

	private

	def task_params
		params.require(:task).permit(:title, :description, :date, :list_id)
	end

	def task
		current_user.tasks.find(params[:id])
	end

	def owner
		task = Task.all.find(params[:id])
		task.user == current_user
	end
end

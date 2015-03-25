class Api::TasksController < ApplicationController



	private
	def task_params
		params.require(:task).permit(:title, :description, :date, :list_id)
	end
end
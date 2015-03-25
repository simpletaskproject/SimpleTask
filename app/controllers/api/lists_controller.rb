class Api::ListsController < ApplicationController
	before_action :authenticate_user!

	def index
		render json: current_user.lists
	end

	def show
		render json: current_user.lists.friendly.find(params[:id])
	end

	def create
		render json: List.create!(list_params)
	end

	def update
		list = current_user.lists.friendly.find(params[:id])
		list.update!(list_params)
		render json: list
	end
	
	def destroy
		list = current_user.list.friendly.find(params[:id])
		list.destroy!
		head 200
	end


	private
	def list_params
		params.require(:list).permit(:title, :user_id)
	end
end
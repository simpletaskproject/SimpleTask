class Api::ListsController < ApplicationController



	private
	def list_params
		params.require(:list).permit(:title, :user_id)
	end
end
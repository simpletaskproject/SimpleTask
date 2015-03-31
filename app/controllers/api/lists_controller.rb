class Api::ListsController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: current_user.lists
  end

  def show
    if owner
      render json: list
    else
      head 401
    end
  end

  def create
    render json: List.create!(list_params)
  end

  def update
    if owner
      list.update!(list_params)
      render json: list
    else
      head 401
    end
  end

  def destroy
    if owner
      list.destroy!
      head 200
    else
      head 401
    end
  end


  private
    def list_params
      params.require(:list).permit(:title, :user_id)
    end

    def list
      current_user.lists.friendly.find(params[:id])
    end

    def owner
      list = List.all.friendly.find(params[:id])
      list.user == current_user
    end
end

class Api::ListsController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: current_user.lists
  end

  def show
    render json: list
  end

  def create
    render json: current_user.lists.create!(list_params)
  end

  def update
    list.update!(list_params)
    render json: list
  end

  def destroy
    list.destroy!
    head 200
  end


  private
    def list_params
      params.require(:list).permit(:title)
    end

    def list
      @list ||= current_user.lists.friendly.find(params[:id])
    end
end

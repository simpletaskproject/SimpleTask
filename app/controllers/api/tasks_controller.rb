class Api::TasksController < ApplicationController
  before_action :authenticate_user!

  def index
    scope = params[:scope]
    render json: current_user.tasks.send(scope)
  end

  def create
    render json: list.tasks.create!(task_params)
  end

  def update
    task.update!(task_params)
    render json: task
  end

  def destroy
    task.destroy!
    head 200
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :date, :list_id)
  end

  def list
    current_user.lists.friendly.find(params[:list_id])
  end

  def task
    current_user.tasks.find(params[:id])
  end
end

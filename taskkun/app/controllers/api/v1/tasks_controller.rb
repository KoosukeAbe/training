class Api::V1::TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  protect_from_forgery except: [:destroy, :create, :update]

  PER = 5

  def index
    @tasks = Task.order("#{params[:category]} #{params[:order]}")
                  .page(params[:page])
                  .where('title LIKE ?', "%#{params[:search]}%")
                  .per(PER)

    render json: { "tasks" => @tasks, "page" => (Task.count / 5.to_f).ceil }
  end

  def show
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      @tasks = Task.all
      render json: @tasks
    else
      render root_path
    end
  end

  def update
    if @task.update(task_params)
      @tasks = Task.all
      render json: @tasks
    else
      render root_path
    end
  end

  def destroy
    data_attributes = @task.attributes
    DeletedTask.create({ title: @task.title, description: @task.description, importance: @task.importance, due_date: @task.due_date, status_id: @task.due_date })

    @task.destroy
    # model名を指定すると、そのmodelと対応するコントローラーのindexアクションのページに遷移する
    @tasks = Task.all
    render json: @tasks
  end

  def task_params
    logger.debug "記事が正しいかどうか: #{params[:title]}"
    params.permit(:title, :description, :importance, :due_date, :status_id)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end

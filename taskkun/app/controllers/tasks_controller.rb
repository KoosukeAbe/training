class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]
  protect_from_forgery except: :destroy

  def index
    if params[:sort_created]
      @tasks = Task.created_latest
    elsif params[:sort_due_date]
      @tasks = Task.due_date_latest
    else
      @tasks = Task.id_oldest
    end
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to task_path(@task)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to task_path(@task)
    else
      render :edit
    end
  end

  def destroy
    DeletedTask.create({ title: @task.title, description: @task.description, importance: @task.importance, due_date: @task.due_date })

    @task.destroy
    # model名を指定すると、そのmodelと対応するコントローラーのindexアクションのページに遷移する
    redirect_to root_path
  end

  def task_params
    params.require(:task).permit(:title, :description, :importance, :due_date)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end

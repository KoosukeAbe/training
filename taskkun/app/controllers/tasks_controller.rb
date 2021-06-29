class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  protect_from_forgery except: :destroy
  PER = 5

  def index
    if params[:sort_created]
      @tasks = Task.created_latest.page(params[:page]).per(PER)
    elsif params[:sort_due_date]
      @tasks = Task.due_date_latest.page(params[:page]).per(PER)
    elsif params[:search]
      @tasks = Task.where(title: params[:title]).or(Task.where(status_id: params[:status])).page(params[:page]).per(PER)
      @keyword = params[:title]
    else
      @tasks = Task.id_oldest.page(params[:page]).per(PER)
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
    data_attributes = @task.attributes
    DeletedTask.create({ title: @task.title, description: @task.description, importance: @task.importance, due_date: @task.due_date, status_id: @task.due_date })

    @task.destroy
    # model名を指定すると、そのmodelと対応するコントローラーのindexアクションのページに遷移する
    redirect_to root_path
  end

  def task_params
    params.require(:task).permit(:title, :description, :importance, :due_date, :status_id)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end

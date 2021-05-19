class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]

  def index
    @tasks = Task.all.order(created_at: :desc)
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    if @task.save # success in submit
      flash[:success] = t('flash.tasks.create.success')
      # redirect_to @task # make GET method
      redirect_to tasks_url
      # GET -> tasks/:id -> tasks/show?
    else # false in submit
      flash.now[:danger] = t('flash.tasks.create.danger')
      # render :new # Not make GET method
      render 'tasks/new'
    end
  end

  def edit
  end

  def update
    if @task.update(task_params) # success in submit
      flash[:success] = t('flash.tasks.update.success')
      redirect_to @task # make GET method
      # GET -> TaskController#show -> tasks/show?
    else # false in submit
      flash[:danger] = t('flash.tasks.update.danger')
      render :edit # Not make GET method
    end
  end

  def destroy
    @task.destroy
    flash[:success] = t('flash.tasks.delete.success')
    redirect_to @task # make GET method
  end

  private # only for this class

  def task_params
    params.require(:task).permit(:name, :description)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end

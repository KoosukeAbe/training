class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]

  def index
    @tasks = Task.all
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      flash[:success] = t('flash.tasks.create.success')
      redirect_to @task
    else
      flash.now[:danger] = t('flash.tasks.create.danger')
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      flash[:success] = t('flash.tasks.update.success')
      redirect_to @task
    else
      flash.now[:danger] = t('flash.tasks.update.danger')
      render :edit
    end
  end

  def destroy
    if @task.destroy
      flash[:success] = t('flash.tasks.delete.success')
    else
      flash.now[:danger] = t('flash.tasks.delete.danger')
    end
    redirect_to tasks_url
  end

  private

  def task_params
    params.require(:task).permit(:name, :description)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end

class TasksController < ApplicationController
  helper_method :sort_column, :sort_order

  before_action :logged_in_user
  before_action :correct_user, only: [:show, :edit, :update, :destroy]

  # 一覧
  def index
    @search_task = SearchTask.new(params, current_user.id)
    @labels = Label.where(user_id: current_user.id)
    @tasks = @search_task.execute()
  end

  # 詳細
  def show
    @task = Task.find(params[:id])
  end

  # 新規作成
  def new
    @task = Task.new
    @labels = current_user.labels
  end

  # 保存 (from new)
  def create
    @task = current_user.tasks.build(task_params)
    @labels = current_user.labels
    if @task.save
      flash[:success] = t('task.create.success')
      redirect_to root_url
    else
      render 'new'
    end

  end

  # 編集
  def edit
    @task = Task.find(params[:id])
    @labels = current_user.labels
  end

  # 保存 (from edit)
  def update
    @task = Task.find(params[:id])
    @labels = current_user.labels
    if @task.update_attributes(task_params)
      flash[:success] = t('task.update.success')
      redirect_to root_url
    else
      render 'edit'
    end
  end

  # 削除
  def destroy
    Task.find(params[:id]).destroy
    flash[:success] = t('task.delete.success')
    redirect_to tasks_url
  end

  private

  def task_params
    params.require(:task).permit(
      # MEMO labels: にすると model にしないといけない
      # :name, :content, :expire_date, :status, labels: []
      :name, :content, :expire_date, :status, label_ids: []
    )
  end

  def sort_order
    @search_task.sort_order
  end

  def sort_column
    @search_task.sort_column
  end

  def correct_user
    @task = Task.where(id: params[:id]).where(user_id: current_user.id)
    redirect_to(login_url) unless @task.present?
  end
end

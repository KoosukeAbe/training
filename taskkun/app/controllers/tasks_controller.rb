class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]
  protect_from_forgery except: :destroy

  PER = 5

  def index
    if params[:title].blank? == false && params[:status].blank? == false
      @tasks = Task.sort_by_title_status(params[:title], params[:status])
                  .page(params[:page])
                  .per(PER)
      @keyword = params[:title]
      @status = params[:status]

    elsif params[:title].blank? == false
      @tasks = Task.where('title LIKE ?', "%#{params[:title]}%")
                  .page(params[:page])
                  .per(PER)
      @keyword = params[:title]

    elsif params[:status].blank? == false
      @tasks = Task.where(status_id: params[:status])
                  .page(params[:page])
                  .per(PER)
      @status = params[:status]

    else
      @tasks = Task.order("#{params[:category]} #{params[:order]}")
                  .page(params[:page])
                  .per(PER)
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

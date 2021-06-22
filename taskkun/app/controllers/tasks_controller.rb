class TasksController < ApplicationController
    before_action :set_task, only: [:show, :edit, :update, :destroy]
    protect_from_forgery except: :destroy

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
            redirect_to @task
        else
            render :new
        end
    end
    
    def edit
    end

    def update
        if @task.update(task_params)
            redirect_to @task 
        else   
            render :edit
        end  
    end

    def destroy
        @task.destroy
        # model名を指定すると、そのmodelと対応するコントローラーのindexアクションのページに遷移する
        redirect_to @task
    end

    def task_params
        params.require(:task).permit(:title, :description, :importance, :due_date)
    end

    def set_task
        @task = Task.find(params[:id])
    end
end

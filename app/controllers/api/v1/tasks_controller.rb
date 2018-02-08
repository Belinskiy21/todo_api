class Api::V1::TasksController < Api::V1::ApiController
  before_action :set_project
  before_action :set_project_task, only: [:show, :update, :destroy]

  resource_description do
    short 'List of tasks inside a project'
    error code: 401, desc: 'Unauthorized'
    error code: 404, desc: 'Not Found'
    error code: 422, desc: 'Unprocessable entity'
    error code: 500, desc: 'Internal Server Error'
    formats ['json']
  end

  def_param_group :task do
    param :task, Hash, action_aware: true, required: true do
      param :project_id, :number, required: true
      param :title, String, required: true
    end
  end

  api :GET, '/projects/:project_id/tasks', "Return projects's tasks"
  def index
    json_response(@project.tasks)
  end

  api :GET, '/projects/:project_id/tasks/:id', "Return task by id"
  param_group :task
  def show
    json_response(@task)
  end

  api :POST, '/projects/:project_id/tasks', 'Create new task'
  param_group :task
  def create
    @task = @project.tasks.create!(task_params)
    json_response(@task, :created)
  end

  api :PUT, '/projects/:project_id/tasks/:id', 'Update task'
  param_group :task
  param :id, :number, required: true
  def update
    Task.change(@task, params[:move]) if params[:move]
    @task.update(task_params)
    json_response(@task, :updated)
  end

  api :DELETE, '/projects/:project_id/tasks/:id', 'Desroy task by :id'
  param :id, :number, required: true
  def destroy
    @task.destroy
    head :no_content
  end

  private

  def task_params
    params.permit(:title, :done, :deadline, :position)
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_project_task
    @task = @project.tasks.find_by!(id: params[:id]) if @project
  end
end

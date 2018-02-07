class Api::V1::CommentsController < Api::V1::ApiController
  before_action :set_project
  before_action :set_project_task
  before_action :set_project_task_comment, only: [:show, :create, :destroy]

  resource_description do
    short 'List of comments on task'
    error code: 401, desc: 'Unauthorized'
    error code: 404, desc: 'Not Found'
    error code: 422, desc: 'Unprocessable entity'
    error code: 500, desc: 'Internal Server Error'
    formats ['json']
  end

  def_param_group :comment do
    param :project_id, :number, required: true
    param :task_id, :number, required: true
  end

  api :GET, '/projects/:project_id/tasks:task_id/comments', 'List of comments for task'
  param_group :comment
  def index
    json_response(@task.comments)
  end

  api :GET, '/projects/:project_id/tasks/:task_id/comments/:id', 'Return comment by id'
  param_group :comment
  def show
    json_response(@comment)
  end

  api :POST, '/projects/:project_id/tasks:task_id/comments', 'Create new comment'
  param :comment, Object, action_aware: true, required: true do
    param :text, String, required: true
    param :file, File, required: false, desc: 'base64 file image'
  end
  param_group :comment
  def create
    @comment = @task.comments.create!(comment_params)
    json_response(@comment, :created)
  end

  api :POST, '/projects/:project_id/tasks:task_id/comments/:id', 'Destroy comment by id'
  param :id, :number, required: true
  param_group :comment
  def destroy
    @comment.destroy
    head :no_content
  end

  private

  def comment_params
    params.permit(:text, :file)
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_project_task
    @task = @project.tasks.find_by!(id: params[:task_id]) if @project
  end

  def set_project_task_comment
    @comment = @task.comments.find_by!(id: params[:id]) if params[:id]
  end
end

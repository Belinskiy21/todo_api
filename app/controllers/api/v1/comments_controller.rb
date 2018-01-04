class Api::V1::CommentsController < Api::V1::ApiController
  before_action :set_project
  before_action :set_project_task
  before_action :set_project_task_comment, only: [:show, :create, :destroy]


  # GET /projects/:project_id/tasks/:task_id/comments
  def index
    json_response(@task.comments)
  end

  # GET /projects/:project_id/tasks/:task_id/comments/:id
  def show
    json_response(@comment)
  end

  # POST /projects/:project_id/tasks/:task_id/comments
  def create
    @task.comments.create!(comment_params)
    json_response(@project, :created)
  end

  # DELETE /projects/:project_id/tasks/:task_id/comments/:id
  def destroy
    @comment.destroy
    head :no_content
  end

  private

  def comment_params
    params.permit(:text)
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

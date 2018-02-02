class Api::V1::ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :update, :destroy]

  def_param_group :project do
    param :project, Hash, action_aware: true, required: true do
      param :title, String, required: true
    end
  end

  api :GET, '/projects', "Return user's projects"
  def index
    if current_user
      @projects = current_user.projects
      json_response(@projects)
    else
      render json: {}, status: :unauthorized
    end
  end

  api :POST, '/projects', 'Create new project'
  param_group :project
  def create
    @project = current_user.projects.create!(project_params)
    json_response(@project, :created)
  end

  api :GET, '/projects/:id'
  def show
    json_response(@project)
  end

  api :PUT, '/projects/:id', 'Update project title'
  param_group :project
  param :id, :number, required: true
  def update
    @project.update(project_params)
    head :no_content
  end

  api :DELETE, '/projects/:id', 'Desroy certain list of tasks with project'
  param :id, :number, required: true
  def destroy
    @project.destroy
    head :no_content
  end

  private

  def project_params
    # whitelist params
    params.permit(:title)
  end

  def set_project
    @project = Project.find(params[:id])
  end
end

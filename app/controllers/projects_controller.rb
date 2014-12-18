class ProjectsController < ApplicationController
  before_action :set_project, only: [:edit, :update, :destroy]

  # GET /projects
  def index
    @projects = Project.all
  end

  # GET /projects/1
  def show
    if params[:slug]
      @project = Project.find_by(slug: params[:slug])
    else
      @project = Project.find(params[:id])
    end
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  def create
    @project = Project.new(params[:project].permit(:name, :company_id, :default_rate, :slug))

    if @project.save
      redirect_to @project, notice: 'Project Created.'
    else
      render :new
    end
  end

  # PATCH/PUT /projects/1
  def update
    if @project.update(params[:project].permit(:name, :company_id, :default_rate, :slug))
      redirect_to @project, notice: 'Project Updated.'
    else
      render :edit
    end
  end

  # DELETE /projects/1
  def destroy
    @project.destroy
    redirect_to projects_url, notice: 'Project was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end
end

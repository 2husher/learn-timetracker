class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [:edit, :update, :destroy]

  # GET /projects
  def index
    @projects = Project.all
    respond_to do |format|
      format.html
      format.csv { send_data Project.export_csv(@projects), type: 'text/csv; sharset=utf-8; header= present', disposition: 'attachment; filename=contacts.csv' }
    end
  end

  # GET /projects/1
  def show
    if params[:slug]
      @project = Project.find_by(slug: params[:slug])
    else
      @project = Project.find(params[:id])
    end
    @work = Work.new
    @work.project = @project

    # @work = @project.works.new
    respond_to do |format|
      format.html
      format.json { render json: @project.works}
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
      Usermailer.projectupdated_email(@project).deliver
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

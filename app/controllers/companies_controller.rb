class CompaniesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :only_admins_can_create_update_companies, only: [:new, :create, :edit, :update]
  before_action :set_company, only: [:show, :edit, :update, :destroy]

  # GET /companies
  def index
    @companies = Company.all
  end

  # GET /companies/1
  def show
    respond_to do |format|
      format.html
      format.json { render json: @company }
      format.xml { render xml: @company }
    end
  end

  # GET /companies/new
  def new
    @company = Company.new
  end

  # GET /companies/1/edit
  def edit
  end

  # POST /companies
  def create
    @company = Company.new(params[:company].permit(:name))

    if @company.save
      redirect_to @company, notice: 'Company Created.'
    else
      render :new
    end
  end

  # PATCH/PUT /companies/1
  def update
    if @company.update(params[:company].permit(:name))
      redirect_to @company, notice: 'Company Updated.'
    else
      render :edit
    end
  end

  # DELETE /companies/1
  def destroy
    @company.destroy
    redirect_to companies_url, notice: 'Company was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    def only_admins_can_create_update_companies
      unless current_user.admin
        redirect_to companies_path, alert: "Only admins can create/modify companies"
      end
    end
end

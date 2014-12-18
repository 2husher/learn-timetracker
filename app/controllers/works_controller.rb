class WorksController < ApplicationController
  before_action :set_work, only: [:show, :edit, :update, :destroy]

  # GET /works
  def index
    if params[:days]
      @works = Work.recentdays(params[:days]).order('datetimeperformed desc')
    else
      @works = Work.all.order('datetimeperformed desc')
    end
  end

  # GET /works/1
  def show
  end

  # GET /works/new
  def new
    @work = Work.new
  end

  # GET /works/1/edit
  def edit
  end

  # POST /works
  def create
    @work = Work.new(params[:work].permit(:project_id, :user_id, :datetimeperformed, :hours))

    if @work.save
      redirect_to @work, notice: 'Work Created.'
    else
      render :new
    end
  end

  # PATCH/PUT /works/1
  def update
    if @work.update(params[:work].permit(:project_id, :user_id, :datetimeperformed, :hours))
      redirect_to @work, notice: 'Work Updated.'
    else
      render :edit
    end
  end

  # DELETE /works/1
  def destroy
    @work.destroy
    redirect_to works_url, notice: 'Work was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_work
      @work = Work.find(params[:id])
    end
end

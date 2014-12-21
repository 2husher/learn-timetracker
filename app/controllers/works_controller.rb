class WorksController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :set_work, only: [:show, :edit, :update, :destroy]

  # GET /works
  def index
    if params[:days]
      @works = Work.recentdays(params[:days]).order('datetimeperformed desc').paginate(page: params[:page])
    else
      @works = Work.all.order('datetimeperformed desc').paginate(page: params[:page])
    end
  end

  # GET /works/1
  def show
    respond_to do |format|
      format.html
      format.json { render json: @work}
    end
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
    @work = Work.new(params[:work].permit(:project_id, :datetimeperformed, :hours, :doc))
    @work.user = current_user

    if params[:doc]
      upload_file_to_work(@work, params[:doc])
    end

    respond_to do |format|
      if @work.save
        Usermailer.workcreated_email(@work).deliver
        format.html { redirect_to @work, notice: 'Work Created.' }
        format.js
      else
        format.html { render :new }
        format.js
      end
    end
  end

  # PATCH/PUT /works/1
  def update
    @work.user = current_user

    if params[:doc]
      upload_file_to_work(@work, params[:doc])
    end

    if @work.update(params[:work].permit(:project_id, :datetimeperformed, :hours, :doc))
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

    def upload_file_to_work(work, uploaded_io)
      File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
        file.write(uploaded_io.read)
        work.doc = uploaded_io.original_filename
      end
    end
end

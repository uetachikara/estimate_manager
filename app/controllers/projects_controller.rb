class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show edit update destroy ]

  # GET /projects or /projects.json
  def index
    @projects = current_user.projects.includes(:client).order(created_at: :desc)
  end

  # GET /projects/1 or /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = current_user.projects.new
    @clients = current_user.clients
  end

  # GET /projects/1/edit
  def edit
    @clients = current_user.clients
  end

  # POST /projects or /projects.json
  def create
    @project = current_user.projects.new(project_params)
    if @project.save
      redirect_to @project, notice: t("notices.project.created")
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /projects/1 or /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: t("notices.project.updated"), status: :see_other }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1 or /projects/1.json
  def destroy
    @project.destroy!

    respond_to do |format|
      format.html { redirect_to projects_path, notice: t("notices.project.destroyed"), status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = current_user.projects.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.require(:project).permit(:name, :status, :note, :client_id)
    end
end

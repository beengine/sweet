class ProjectsController < ApplicationController
  before_action :authenticate_user!

  def index
    @projects=current_user.projects.all
    @project=Project.new
    @task=Task.new
  end

  def create
    @project = current_user.projects.new(project_params)
   
    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'User was successfully created.' }
        format.js   { @task=Task.new }
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @project = current_user.projects.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(project_params)
        format.html { redirect_to(@project, :notice => 'Project was successfully updated.') }
        format.js   {}
        format.json { respond_with_bip(@project) }
      else
        format.html { render :action => "edit" }
        format.json { respond_with_bip(@project) }
      end
    end
  end

  def destroy
    @project=current_user.projects.find(params[:id])
    @project.destroy
    respond_to do |format|
      format.html { redirect_to products_url }
      format.js   {}
      format.json { head :no_content }
    end
  end

private

  def project_params
    params.require(:project).permit(:name)
  end
end

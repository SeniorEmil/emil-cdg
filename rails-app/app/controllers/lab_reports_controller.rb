class LabReportsController < ApplicationController
    # before_action :find_lab, only: %i[show update destroy edit mark grade]

    def index
      @lab_reports = LabReport.all
    end

    def show
      @lab_report=LabReport.find(params[:id])
    end

    def new
      @lab_report = LabReport.new
    end

    def create
      lab=LabReport.new(params.require(:lab_report).permit(:title,:description))
      lab.user_id=1
      if lab.save
        redirect_to root_url
        flash[:success] = "Lab report was added"
      else
        render :new
        flash[:DANGER] = "Some error occured"
      end
    end

    def edit
      @lab_report=LabReport.find(params[:id])
    end

    def update
      @lab_report=LabReport.find(params[:id])
      if @lab_report.update(params.require(:lab_report).permit(:title,:description))
        redirect_to root_url
        flash[:success] = "Lab was updated successfully"
      else
        render :edit
        flash[:DANGER] = "Some error occured"
      end
    end

    def mark
      @lab_report=LabReport.find(params[:id])
    end

    def grade
      @lab_report=LabReport.find(params[:id])
      if @lab_report.update(params.permit(:grade))
        redirect_to root_url
        flash[:success] = "Mark was added successfully"
      else
        render :mark
        flash[:DANGER] = "Some error occured"
      end
    end

    def destroy
      @lab_report=LabReport.find(params[:id])
      @lab_report.destroy
      redirect_to action: :index
      flash[:success] = "Lab was deleted successfully"
    end

    # private
    #
    # def find_lab
    #   @lab_report = LabReport.find params[:id]
    # end
    #
    # def lab_params
    #   params.require(:lab_report).permit(:title, :description)
    # end
end

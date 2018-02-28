class ResumesController < ApplicationController

  def create
    @resume = current_user.resumes.new(resume_params)
    if @resume.save!
      ResumeEntityService.new.generate(@resume)
      redirect_to dashboard_index_path
    else
      flash.notice = "Something went wrong, try adding your resume again."
      redirect_to dashboard_index_path
    end
  end

  private

    def resume_params
      if params[:image]
        params[:body] = GoogleVisionService.analyze(params[:image]).text
      end
      params.permit(:name, :body)
    end

end

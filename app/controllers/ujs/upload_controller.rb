class Ujs::UploadController < ApplicationController
  def create
    @upload = Upload.new(
        category: params[:category],
        filename: params[:file],
        job_id: params[:job]
    )

    if Upload.where(job_id: @upload['job_id'],
                    category: @upload[:category],
                    filename: @upload.filename.file.filename).empty?
      if @upload.save!
        respond_to do |format|
          format.js
        end
      end
    else
      render json: {error: 'File already exist'}, status: :conflict
    end
  end

  def destroy
    @upload = Upload.find(params[:id])

    if @upload.destroy!
      respond_to do |format|
        format.js
      end
    else
      render json: {error: 'Could not remove upload'}, status: :internal_server_error
    end
  end
end

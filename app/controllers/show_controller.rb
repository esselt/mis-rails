class ShowController < ApplicationController
  def destroy
    @job = Job.find(params[:id])
    @job.destroy

    redirect_to show_index_path
  end

  def show
    @job = Job.find(params[:id])
    @invoices = @job.uploads.where(category: :invoice)
                    .where.not(id: Match.select(:upload_id).where(job_id: @job.id))
    @attachments = @job.uploads.where(category: :attachment)
                       .where(invoice_id: nil)
  end

  def index
    @jobs = Job.order(id: :desc).page(params[:page])
  end
end

class RunController < ApplicationController
  include Wicked::Wizard
  steps :upload_invoices,
        :process_invoices,
        :upload_attachments,
        :process_attachments,
        :confirm_status,
        :send_email,
        :done

  def show
    @job = Job.find(params[:job_id])
    @job.update_attributes(status: wizard_value(step))

    case wizard_value(step)
      when :upload_invoices
        @uploads = @job.uploads.where(category: :invoice)
      when :process_invoices
        @uploads = @job.uploads.where(category: :invoice)
                       .where.not(id: Match.select(:upload_id).where(job_id: @job.id))
        @matches = @job.matches
      when :upload_attachments
        @uploads = @job.uploads.where(category: :attachment)
      when :process_attachments
        @uploads = @job.uploads.where(category: :attachment)
                       .where(invoice_id: nil)
        @matches = @job.matches
      when :confirm_status
        @invoices = @job.uploads.where(category: :invoice)
                        .where.not(id: Match.select(:upload_id).where(job_id: @job.id))
        @attachments = @job.uploads.where(category: :attachment)
                           .where(invoice_id: nil)
        @matches = @job.matches
      when :send_email
        @matches = @job.matches
      when :done
        redirect_to root_path
    end

    render_wizard unless wizard_value(step) == :done
  end

  def new
    @job = Job.create(status: wizard_value(steps.first), user_id: current_user.id)

    redirect_to wizard_path(wizard_value(steps.first),
                            :job_id => @job.id)
  end
end

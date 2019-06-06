class MergePdfJob < ActiveJob::Base
  queue_as :merge

  after_perform do |job|
    match = job.arguments.first
    max_size = Setting.pull(:email_max_size).value.to_i * 1024 * 1024

    if max_size > 0 && max_size < (match.upload.combined.filename.file.size * 1.37).to_i
      match.update(status: :error, error: "Attachment exceeds size limit. Size Size: #{match.upload.combined.filename.file.size}, limit: #{max_size}")

      body = %Q[
Could not send message, attachment exceeds size limit for mail.

Subject: #{match.title}
Attachment: #{match.upload.combined.filename_identifier} (Size: #{match.upload.combined.filename.file.size}, limit: #{max_size})
Body:
#{match.message}
      ]

      Rails.logger.warn(body)
    else
      PdfMailer.send_mail(match).deliver_later
    end
  end

  def perform(match=Match.new)
    filename = match.upload.filename_identifier
    full_path = Rails.root.join('tmp', filename)
    begin
      combined_pdf = CombinePDF.new
      combined_pdf << CombinePDF.load(match.upload.filename.file.file)
      match.upload.attachments.order(:filename).each do |attachment|
        combined_pdf << CombinePDF.load(attachment.filename.file.file)
      end

      combined_pdf.save(full_path)

      combined = Upload.create(job_id: match.job_id, category: 'combined')
      combined.filename = Pathname(full_path).open
      combined.save!

      match.upload.update(combined_id: combined.id)
      match.update(status: :combined)
    ensure
      full_path.unlink
    end
  end
end

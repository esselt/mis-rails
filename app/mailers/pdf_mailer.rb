class PdfMailer < ApplicationMailer
  def send_mail(match=Match.new)
    from = Setting.pull(:email_from).value
    bcc = Setting.pull(:email_copy).value
    reply_to = Setting.pull(:email_reply_to).value || bcc

    attachments[match.upload.combined.filename_identifier] = File.read(match.upload.combined.filename.file.file)

    mail(
        to: match.email,
        subject: match.title,
        body: match.message,
        from: from,
        bcc: bcc,
        reply_to: reply_to
    )

    match.update(status: :sent, sent_at: Time.now)
  end
end

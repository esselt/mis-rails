class Ujs::MatchController < ApplicationController
  def destroy
    match = Match.find(params[:id])

    match.upload.attachments.each do |upload|
      upload.update(invoice_id: nil)
    end

    if match.destroy!
      respond_to do |format|
        format.js { render 'ujs/match/destroy', locals: {match: match} }
      end
    else
      render 'ujs/match/upload_error',
             locals: {id: params[:id], error: 'Could not remove match'},
             status: :internal_server_error
    end
  end

  def match
    upload = Upload.find(params[:id])

    return render 'ujs/match/upload_error',
                  locals: {id: params[:id], category: upload.category, error: 'Has already been matched'},
                  status: :conflict if upload.match

    upload_match = Setting.pull("match_#{upload.category}".to_sym).value.html_safe
    customer_id = upload.filename_identifier.match(upload_match).captures.first.to_s

    case upload.category
      when 'invoice'
        match_invoice(upload, customer_id)
      when 'attachment'
        match_attachment(upload, customer_id)
      else
        render 'ujs/match/upload_error',
               locals: {id: params[:id], category: upload.category, error: 'Unknown attachment'},
               status: :unprocessable_entity
    end
  rescue NoMethodError
    return render 'ujs/match/upload_error',
                  locals: {id: params[:id], category: upload.category, error: 'Could not extract customer from filename'},
                  status: :unprocessable_entity
  end

  private
  def match_invoice(upload, customer_id)
    customer = MamutCustomer.find(customer_id)

    match = create_match(upload, customer)

    respond_to do |format|
      format.js { render 'ujs/match/invoice', locals: {match: match} }
    end if match
  rescue ActiveRecord::RecordNotFound
    render 'ujs/match/upload_error',
           locals: {id: params[:id], category: upload.category, error: 'Could not find customer'},
           status: :not_found
  end

  def match_attachment(upload, customer_id)
    match = Match.where(job_id: upload.job_id).where(customer_id: customer_id).first

    return render 'ujs/match/upload_error',
                  locals: {id: params[:id], category: upload.category, error: 'Could not find a match'},
                  status: :not_found unless match

    respond_to do |format|
      format.js { render 'ujs/match/attachment', locals: {upload: upload, match: match} }
    end if upload.update!(invoice_id: match.upload.id)
  rescue ActiveRecord::RecordInvalid => error
    render 'ujs/match/upload_error',
           locals: {id: params[:id], category: upload.category, error: error.message},
           status: :unprocessable_entity
    return false
  end

  def create_match(upload, customer)
    title = Setting.pull(:email_title).value.to_s.html_safe || 'NA'
    message = Setting.pull(:email_message).value.to_s.html_safe || 'NA'

    Match.create!(
        status: :matched,
        customer_id: customer.id,
        name: customer.ContactName.strip,
        email: customer.Email.strip,
        title: str_replace(title, customer),
        message: str_replace(message, customer),
        job_id: upload.job_id,
        upload_id: upload.id
    )
  rescue ActiveRecord::RecordInvalid => error
    render 'ujs/match/upload_error',
           locals: {id: params[:id], category: upload.category, error: error.message},
           status: :unprocessable_entity
    return false
  end

  def str_replace(string, customer)
    new_string = string.dup

    string.scan(/{{([a-zA-Z0-9\-_]+)}}/).each do |match|
      new_string.gsub!("{{#{match.first}}}", customer[match.first].to_s.strip)
    end

    new_string
  end
end

class Job < ActiveRecord::Base
  has_many :matches, :dependent => :destroy
  has_many :uploads, :dependent => :destroy

  belongs_to :user

  validates :status, presence: true
  validates :status, inclusion: {in: %w(upload_invoices
                                        process_invoices
                                        upload_attachments
                                        process_attachments
                                        confirm_status
                                        send_email
                                        done)}
end

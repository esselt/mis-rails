class Upload < ActiveRecord::Base
  belongs_to :job
  has_one :match
  has_many :attachments, class_name: 'Upload', foreign_key: :invoice_id
  belongs_to :invoice, class_name: 'Upload'
  belongs_to :combined, class_name: 'Upload', foreign_key: :combined_id

  validates :category, :filename, :job_id, presence: true
  validates :category, inclusion: {in: %w(invoice attachment combined)}

  mount_uploader :filename, PdfUploader
end

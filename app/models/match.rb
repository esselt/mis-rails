class Match < ActiveRecord::Base
  belongs_to :job
  belongs_to :upload

  validates :status, :customer_id, :name, :email, :title, :message, :job_id, presence: true
  validates :status, inclusion: {in: %w(matched processing combined sent error)}
end

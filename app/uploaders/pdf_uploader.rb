# encoding: utf-8

class PdfUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    "uploads/job_#{model.job_id}/#{model.category}"
  end

  def extension_whitelist
    %w(pdf)
  end
end

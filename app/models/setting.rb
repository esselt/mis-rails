class Setting < ActiveRecord::Base
  @settings = [
      :email_title,
      :email_message,
      :email_from,
      :email_copy,
      :email_reply_to,
      :email_max_size,
      :match_invoice,
      :match_attachment
  ]

  validates :version, :setting, presence: true

  def self.pull(setting, no_cache=false)
    if @settings.include?(setting)
      Rails.cache.delete("pull/#{setting}") if no_cache

      Rails.cache.fetch("pull/#{setting}", expires_in: 1.minute) do
        where(setting: setting, version: Setting.where(setting: setting)
                                             .maximum(:version))
            .group('setting')
            .limit(1).first_or_create do |record|
          record.setting = setting
          record.version = 0
        end
      end
    end
  end

  def self.push(setting, value)
    if @settings.include?(setting)
      create!(setting: setting, version: (pull(setting).version + 1), value: value)
    end
  end

  def self.pull_all(no_cache=false)
    ret = []
    @settings.each do |setting|
      ret << pull(setting, no_cache)
    end

    return ret
  end

  def versions
    Setting.where(setting: setting).order(version: :desc)
  end

  def help
    case setting.to_sym
      when :email_title
        return 'Title for emails to be sent. Use {{text}} to add variables, ' \
            'matches database columns for database view External_Customer. ' \
            'Commonly used columns: CustomerID, ContactName, Email & ProjectName'
      when :email_message
        return 'Message in emails to be sent. Use {{text}} to add variables, ' \
            'matches database columns for database view External_Customer. ' \
            'Commonly used columns: CustomerID, ContactName, Email & ProjectName'
      when :email_from
        return 'E-mail address used for sending, if multiple addresses separate with semicolon (;)'
      when :email_copy
        return 'E-mail address to send blind copy, if multiple addresses separate with semicolon (;)'
      when :email_reply_to
        return 'E-mail address used if reply address is not the same as from address'
      when :match_invoice
        return 'Search pattern used for matching customer number in invoices based on filename, finds first group. Uses Ruby based String.match.'
      when :email_max_size
        return 'Max attachment size in MB'
      when :match_invoice_number
        return 'Search pattern used for matching invoice number based on filename, finds first group. Uses Ruby based String.match.'
      when :match_attachment
        return 'Search pattern used for matching customer number in attachments based on filename, finds first group. Uses Ruby based String.match.'
    end
  end
end

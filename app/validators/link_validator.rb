class LinkValidator < ActiveModel::EachValidator
  DEFAULT_MESSAGE = 'Invalid GitHab url format'.freeze
  VALID_EMAIL_GITHAB = %r{^https://github\.com/}i.freeze

  def validate_each(record, attribute, value)
    return if value =~ VALID_EMAIL_GITHAB

    record.errors[attribute] << (options[:message] || DEFAULT_MESSAGE)
  end
end

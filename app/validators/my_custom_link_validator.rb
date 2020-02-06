class MyCustomLinkValidator < ActiveModel::Validator
  VALID_EMAIL_GITHAB = %r{^https://github\.com/}i.freeze

  def validate(record)
    return if record.link =~ VALID_EMAIL_GITHAB

    record.errors[:link] << 'Invalid GitHab url format'
  end
end

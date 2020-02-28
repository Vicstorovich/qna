return if ENV['SKIP_VARS_CHEK'].present?

required = %w[
  CURRENT_HOST
]

if Rails.env.development?
  required += %w[
    DATABASE_DEV TIME_ZONE
  ]
end

if Rails.env.test?
  required += %w[
    DATABASE_TEST TIME_ZONE
  ]
end

missing = required.reject { |e| ENV.key?(e) }

if missing.any?
  missing.each { |e| puts "Missing env #{e}" }
  raise 'Missing ENVs'
end

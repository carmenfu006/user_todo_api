class JsonWebTokenService
  SECRET_KEY = Rails.application.credentials.config[:secret_key_base].to_s

  # def self.encode(payload, exp = 24.hours.from_now)
  #   payload[:exp] = exp.to_i
  # end

  def self.encode(payload)
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    JWT.decode(token, SECRET_KEY)
  end
end
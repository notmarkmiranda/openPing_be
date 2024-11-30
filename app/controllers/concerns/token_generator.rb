module TokenGenerator
  def generate_token(user)
    payload = { user_id: user.id }
    JWT.encode(payload, Rails.application.credentials.secret_key_base)
  end
end

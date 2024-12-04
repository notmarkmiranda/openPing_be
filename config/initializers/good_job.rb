GoodJob::Engine.middleware.use(Rack::Auth::Basic) do |username, password|
  ActiveSupport::SecurityUtils.secure_compare(Rails.application.credentials.good_job_username, username) &
    ActiveSupport::SecurityUtils.secure_compare(Rails.application.credentials.good_job_password, password)
end

KEYS = {}

if Rails.env == 'production'
  KEYS[:open_tok] = {}
  KEYS[:open_tok][:key] = ENV["OPENTOK-KEY"]
  KEYS[:open_tok][:secret] = ENV["OPENTOK-SECRET"]
  KEYS[:facebook] = {}
  KEYS[:facebook][:key] = ENV["FACEBOOK-KEY"]
  KEYS[:facebook][:secret] = ENV["FACEBOOK-SECRET"]
else
  KEYS = HashWithIndifferentAccess.new(YAML.load_file("#{Rails.root}/config/secrets.yml"))
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, KEYS[:facebook][:key], KEYS[:facebook][:secret],
           :scope => 'email,user_location'
end
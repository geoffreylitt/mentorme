KEYS = {}

if Rails.env == 'production'
  KEYS[:open_tok] = {}
  KEYS[:open_tok][:key] = ENV["OPENTOK-KEY"]
  KEYS[:open_tok][:secret] = ENV["OPENTOK-SECRET"]
else
  KEYS = HashWithIndifferentAccess.new(YAML.load_file("#{Rails.root}/config/secrets.yml"))
end
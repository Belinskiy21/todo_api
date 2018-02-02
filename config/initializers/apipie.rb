class FileValidator < Apipie::Validator::BaseValidator

  def validate(value)
    value.is_a?(Rack::Test::UploadedFile) || value.is_a?(ActionDispatch::Http::UploadedFile)
  end

  def self.build(param_description, argument, options, block)
    self.new param_description if argument == File
  end

  def description
    'Must be a valid file'
  end

end

Apipie.configure do |config|
  config.app_name                = "TodoApi"
  config.api_base_url            = "/api/v1"
  config.doc_base_url            = "/apipie"
  # where is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/api/v1/*.rb"
  config.translate               = false
  config.default_locale          = nil
  config.show_all_examples       = true
  config.validate                =  FileValidator.new(File)
end

configure do
  # Log queries to STDOUT in development
  if Sinatra::Application.development?
    ActiveRecord::Base.logger = Logger.new(STDOUT)
  end

  set :database, {
    adapter: "sqlite3",
    database: "db/db.sqlite3"
  }

  # Load all models from app/models, using autoload instead of require
  # See postgres://vxeavjpupmdnxc:eb0bf379afd967455809d32e63e792180765b178d8a09ab16e33f1a9ad20b9ad@ec2-34-194-215-27.compute-1.amazonaws.com:5432/d8a7ginmdkoe7b
  Dir[APP_ROOT.join('app', 'models', '*.rb')].each do |model_file|
    filename = File.basename(model_file).gsub('.rb', '')
    autoload ActiveSupport::Inflector.camelize(filename), model_file
  end

end

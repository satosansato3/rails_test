set :app_eip, "13.230.62.217"

role :app, "admin@#{fetch(:app_eip)}"
role :web, "admin@#{fetch(:app_eip)}"
role :db, "admin@#{fetch(:app_eip)}"

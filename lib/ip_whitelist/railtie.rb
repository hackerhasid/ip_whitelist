module IpWhitelist
  class Railtie < Rails::Railtie
    initializer "railtie.configure_rails_initialization" do |app|
      app.config.middleware.insert_after Rails::Rack::Logger, Rack::IpWhitelist
    end
  end
end

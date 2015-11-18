require "ip_whitelist/railtie" if defined? Rails
require "ip_whitelist/version"

module Rack
  class IpWhitelist
    def initialize(app, yaml_file=nil)
      @app = app
      process_yaml_data(yaml_file)
    end

    def call(env)
      if @allow_all || white_listed?(env)
        @app.call(env)
      else
        [ 403, {"Content-Type" => "text/html"}, ["<h1>Access Not Allowed</h1><p>You are not allowed to view this site.</p>"] ]
      end
    end

    private

    def process_yaml_data(yaml_file)
      file_path = yaml_file.nil? ? Rails.root.join('config','whitelist.yml') : Rails.root.join(yaml_file)
      yaml_data = YAML.load_file(file_path) rescue {}
      @allow_all = !yaml_data.keys.include?(Rails.env) # if no environment listed, then no whitelist. allow all.
      @ip_addresses = [yaml_data[Rails.env]].flatten.compact rescue []
      Rails.logger.info "@ip_addresses set to #{@ip_addresses}"
    end

    def white_listed?(env)
      ip = get_remote_ip(env)
      if @ip_addresses.include?(ip)
        return true
      else
        Rails.logger.info "IP Whitelist Denied for IP: #{ip}"
        return false
      end
    end

    def get_remote_ip(env)
      if (!env["HTTP_X_FORWARDED_FOR"].blank?)
        env["HTTP_X_FORWARDED_FOR"].split(',')[-1].strip
      else
        env["REMOTE_ADDR"]
      end
    end
  end
end

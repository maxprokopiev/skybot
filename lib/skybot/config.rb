require 'yaml'

module Skybot

  class Config

    def self.load
      puts "loading config"
      @@config = ""
      begin
      File.open(File.dirname(__FILE__) + '/../../config/config.yml', 'r') do |file| 
        puts "reading file"
        file.each_line do |line|
          @@config += line + "\n"
        end
      end
      rescue Exception => e
        puts "#{ e } (#{ e.class })!"
      end
      @@config = YAML::load(@@config)
      puts "config loaded"
      @@config
    end

    def save
      File.open(File.dirname(__FILE__) + '/../../config/config.yml', 'w+') do |file| 
        file.puts @@config.to_yaml 
      end
    end
  end

end

require File.dirname(__FILE__) + '/config'

module Skybot

  class Scripts

    def self.scripts
      @@scripts
    end

    def self.register(settings, &block)
      @@scripts << { :settings => settings, :code_block => block }
    end

    def self.process(bot)
      @@scripts.each do |script|
        matches = script[:settings][:command].match(bot.message)
        if matches
          allowed_users = bot.config[script[:settings][:name]][:users] rescue nil
          if (!allowed_users) || (allowed_users && allowed_users.include?(bot.message_from))
            script[:code_block].call(bot, matches)
          elsif allowed_users
            bot.reply "/me : Permission denied for #{bot.message_from}"
          end
        end
      end
    rescue Exception => e
      puts "#{ e } (#{ e.class })!"
      puts e.backtrace
    end

    def self.load_scripts
      @@scripts = []
      Dir[File.dirname(__FILE__) + '/../../scripts/*.rb'].each { |script| require script }
    end
    load_scripts

  end

end

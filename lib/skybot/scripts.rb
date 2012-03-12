require File.dirname(__FILE__) + '/config'

module Skybot

  class Scripts
   
    def self.register(settings, &block)
      @@scripts << { :settings => settings, :code_block => block }
    end

    def self.process(bot)
      @@scripts.each do |script|
        matches = script[:settings][:command].match(bot.message)
        script[:code_block].call(bot, matches) if matches
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

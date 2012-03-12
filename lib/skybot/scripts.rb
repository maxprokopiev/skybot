require File.dirname(__FILE__) + '/config'

module Skybot

  class Scripts
   
    def self.respond(regex, &block)
      @@scripts << [regex, block]
    end

    def self.process(bot)
      @@scripts.each do |script|
        matches = script[0].match(bot.message)
        script[1].call(bot, matches) if matches
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

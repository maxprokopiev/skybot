require File.dirname(__FILE__) + '/config'

module Skybot

  class Scripts

    def self.respond(regex)
      matches = regex.match(@@bot.message)
      yield(@@bot, matches) if matches
    end

    def self.process(bot)
      @@bot = bot
      Dir[File.dirname(__FILE__) + "/../../scripts/*.rb"].each do |filename|
        script = ''
        File.open(filename, 'r') do |file| 
          file.each_line { |line| script += line } 
        end
        begin
          Scripts.class_eval script
        rescue Exception => e
          puts "#{ e } (#{ e.class })!"
        end
      end
    end

  end

end

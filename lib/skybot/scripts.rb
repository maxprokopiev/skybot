require File.dirname(__FILE__) + '/config'

module Skybot

  class Scripts

    def self.respond(regex)
      puts 'in respond'
      puts @@bot.class
      puts "respond '#{@@bot.message}'"
      matches = regex.match(@@bot.message)
      if regex.match @@bot.message
        puts 'yield'
        yield(@@bot, matches)
      end
    end

    def self.process(bot)
      puts "in process #{bot.class}"
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

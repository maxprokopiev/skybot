require 'rubygems'
require 'skype'

['config', 'scripts', 'bot'].each do |file|
  require File.dirname(__FILE__) + "/#{file}"
end

module Skybot

  class App

    def initialize
      Skype.init "Skybot"
      Skype.start_messageloop
      Skype.attach_wait

      @skype = Skype::Application.new("Skybot")
      @config = Skybot::Config.load
      puts "bot name is #{@config[:name]}"
    end

    def start
      Skype::ChatMessage.set_notify :status, 'SENT', lambda {|msg| process_message msg}
      Skype::ChatMessage.set_notify :status, 'RECEIVED', lambda {|msg| process_message msg}
      loop {}
    end

    def process_message msg
       puts "Message received from #{msg.get_from.to_s}: "
       puts msg.get_body.to_s
       puts "before match"
       if msg.get_body.to_s.chomp.match(/#{@config[:name]}\s(.*)/m)
         puts 'match'
         bot = Skybot::Bot.new
         bot.chat = msg.get_chat
         bot.message = $1
         puts 'before process'
         Skybot::Scripts.process(bot)
       end
     end

  end

end

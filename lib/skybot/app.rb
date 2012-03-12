require 'rubygems'
require 'skype'

['config', 'scripts', 'bot'].each do |file|
  require File.dirname(__FILE__) + "/#{file}"
end

module Skybot

  class App

    APP_NAME = "Skybot"

    def initialize
      Skype.init APP_NAME
      Skype.start_messageloop
      Skype.attach_wait

      @skype = Skype::Application.new APP_NAME
      @config = Skybot::Config.load
    end

    def start
      Skype::ChatMessage.set_notify :status, 'SENT',     lambda {|msg| process_message msg}
      Skype::ChatMessage.set_notify :status, 'RECEIVED', lambda {|msg| process_message msg}
      loop {}
    end

    def process_message msg
      if Skybot::Bot.message_for_me? msg
        @bot = Skybot::Bot.create_or_find_by_chat(msg.get_chat)
        @bot.set_message msg
        Skybot::Scripts.process(@bot)
      end
    rescue Exception => e
      puts "#{ e } (#{ e.class })!"
      puts e.backtrace
    end

  end

end

require File.dirname(__FILE__) + '/config'

module Skybot

  class Bot
    attr_accessor :config, :chat, :message

    def initialize
      puts 'bot initialize'
      @config = Skybot::Config.load
      puts "bot init done"
    end

    def reply(message)
      @chat.sendMessage(message)
    end

  end

end

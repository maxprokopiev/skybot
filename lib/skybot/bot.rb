require File.dirname(__FILE__) + '/config'

module Skybot

  class Bot
    attr_accessor :config, :chat, :message, :message_from

    @@bots = []
    @@config = Skybot::Config.load

    MESSAGE_PATTERN = /#{@@config[:name]}\s(.*)/m

    def initialize(options = {})
      @chat = options[:chat]
      @config = @@config
      @@bots << self
    end

    def reply(message)
      @chat.sendMessage(message)
    end

    def set_message(msg)
      if Bot.fetch_message_body(msg).match MESSAGE_PATTERN
        self.message = $1 
        self.message_from = msg.get_from.to_s
      end
    end

    def self.message_for_me?(message)
      self.fetch_message_body(message).match MESSAGE_PATTERN
    end

    def self.create_or_find_by_chat(chat)
      @@bots.find {|bot| bot.chat == chat} || Bot.new(:chat => chat)
    end

    private
     
    def self.fetch_message_body(msg)
      msg.get_body.to_s.chomp
    end

  end

end

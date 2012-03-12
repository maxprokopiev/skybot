require File.dirname(__FILE__) + '/config'

module Skybot

  class Bot
    attr_accessor :config, :chat, :message

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
      self.message = $1 if msg.match MESSAGE_PATTERN
    end

    def self.message_for_me?(message)
      message.get_body.to_s.chomp.match MESSAGE_PATTERN
    end

    def self.create_or_find_by_chat(chat)
      @@bots.find {|bot| bot.chat == chat} || Bot.new(:chat => chat)
    end

  end

end

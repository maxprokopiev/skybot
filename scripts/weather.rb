module Skybot
  settings = {
    :name => :weather,
    :command => /weather in (.+)/,
    :description => %q{
      Displaying weather in city

      Usage:
        [Botname] weather in [City]
    }
  }
  Scripts.register settings do |bot, matches|
    require 'open-uri'
    page = open("http://www.google.com/ig/api?weather=#{URI.encode(matches[1])}").read
    require 'rexml/document'
    doc = REXML::Document.new page
    weather = ''
    doc.elements.each('xml_api_reply/weather/current_conditions/temp_c') do |e|
      weather += e.attributes["data"]
    end
    weather += ' '
    doc.elements.each('xml_api_reply/weather/current_conditions/condition') do |e|
      weather += e.attributes["data"]
    end
    bot.reply weather
  end
end



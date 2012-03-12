respond /weather in (.+)/ do |bot, matches|
  require 'open-uri'
  page = open("http://www.google.com/ig/api?weather=#{matches[1]}").read
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



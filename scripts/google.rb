module Skybot
  Scripts.respond /google me (.+)/ do |bot, matches|
    require 'open-uri'
    require 'uri'
    puts "google query: #{matches[1]}"
    page = open(URI.escape("http://www.google.com/search?q=#{matches[1].gsub(/\s/, '+')}")).read
    #puts page
    match = page.match(/"r"><a\shref="(.+?)"/)
    if !match.nil?
      bot.reply match[1]
    else
      bot.reply 'Sorry, no results'
    end
  end
end

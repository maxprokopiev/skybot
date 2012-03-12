module Skybot
  settings = {
    :name => :google_me,
    :command => /google me (.+)/,
    :description => %q{
      Googles for you and replies with first link

      Usage:
        [Botname] google me [search query]
    }
  }
  Scripts.register settings do |bot, matches|
    require 'open-uri'
    require 'uri'
    puts "google query: #{matches[1]}"
    page = open(URI.escape("http://www.google.com/search?q=#{URI.encode(matches[1])}")).read
    #puts page
    match = page.match(/"r"><a\shref="(\/url\?q=)?(.+?)"/)
    if !match.nil?
      bot.reply match[2]
    else
      bot.reply 'Sorry, no results'
    end
  end
end

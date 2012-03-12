module Skybot
  settings = {
    :name => :bash_me,
    :command => /bash me/,
    :description => %q{
      Fetches first citation from bash.org.ru RSS feed

      Usage:
        [Botname] bash me
    }
  }
  Scripts.register settings do |bot, matches|
    require 'rss/2.0'
    require 'cgi'
    require 'open-uri'
    data = open('http://bash.org.ru/rss').read
    parsed = RSS::Parser.parse(data.gsub(/\< hr\>/, '< hr />'), false)
    bot.reply CGI::unescapeHTML(parsed.items.at(rand(parsed.items.size)).description.gsub("\n", "").gsub("<br>", "\n"))
  end
end

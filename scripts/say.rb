respond /say (.*)/ do |bot, matches|
  case matches[1]
  when "hello"
    bot.reply "Hello I am #{bot.config[:name]}"
  else
    bot.reply "/me saying #{matches[1]}"
  end
end

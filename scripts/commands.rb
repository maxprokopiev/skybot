module Skybot
  settings = {
    :name => :help,
    :command => /help/,
    :description => %q{
      Displays all possible commands

      Usage:
        [Botname] help
    }
  }
  Scripts.register settings do |bot, matches|
    commands = []
    Scripts.scripts.each do |script|
      commands << "#{script[:settings][:name]}\n#{script[:settings][:description]}"
    end
    bot.reply commands.join("\n")
  end
end

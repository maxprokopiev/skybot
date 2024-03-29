module Skybot
  settings = {
    :name => :deploy,
    :command => /deploy branch (.+?) of (.+?) to (.+?)$/,
    :description => %q{
      Deploy project

      Usage:
        [Botname] deploy branch [branch_name] of [project_name] to [env_name]
    }
  }
  Scripts.register settings do |bot, matches|
    project = matches[2]
    project_settings = bot.config[:deploy][project.to_sym]
    allowed_users = project_settings[:users]
    if allowed_users.include?(bot.message_from)
      project_path = project_settings[:path]
      branch = matches[1]
      env = matches[3]
      puts "deploying branch #{branch} of #{project} to #{env}"
      puts project_path
      puts `cd #{project_path} && bash deploy.sh #{branch} #{env}`
      bot.reply "/me deployed branch #{branch} of #{project} to #{env}"
    else
      bot.reply "/me : Permission denied for #{bot.message_from}"
    end
  end

  settings = {
    :name => :rollback,
    :command => /rollback (.+?) on (.+?)$/,
    :description => %q{
      Rollback deployed project to previous version

      Usage:
        [Botname] rollback [project_name] on [env_name]
    }
  }
  Scripts.register settings do |bot, matches|
    project = matches[1]
    project_settings = bot.config[:deploy][project.to_sym]
    allowed_users = project_settings[:users]
    if allowed_users.include?(bot.message_from)
      project_path = project_settings[:path]
      env = matches[2]
      puts `cd #{project_path} && bash rollback.sh #{env}`
      bot.reply "/me rollbacked #{project} on #{env}"
    else
      bot.reply "/me : Permission denied for #{bot.message_from}"
    end
  end
end

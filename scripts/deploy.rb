# Bot deploy branch master of project to staging
respond /deploy branch (.+?) of (.+?) to (.+?)$/ do |bot, matches|
  project = matches[2]
  project_path = bot.config[project.to_sym]
  branch = matches[1]
  env = matches[3]
  puts "deploying branch #{branch} of #{project} to #{env}"
  puts project_path
  puts `cd #{project_path} && bash deploy.sh #{branch} #{env}`
  bot.reply "/me deployed branch #{branch} of #{project} to #{env}"
end

respond /rollback (.+?) on (.+?)$/ do |bot, matches|
  project = matches[1]
  project_path = bot.config[project.to_sym]
  env = matches[2]
  puts `cd #{project_path} && bash rollback.sh #{env}`
  bot.reply "/me rollbacked #{project} on #{env}"
end

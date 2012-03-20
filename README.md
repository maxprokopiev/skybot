# Skybot

Bot for skype with custom commands.

# Setup

#### Versions && Dependencies
* Skype
* ruby 1.8.7
* Ruby4Skype (0.4.1)

Copy skype framework to system path:

    cp -R /Applications/Skype.app/Contents/Frameworks/Skype.framework /System/Library/Frameworks/Skype.framework

#### Config file

Create settings file config/config.yml with initial data:

    ---
    :name: Bot

# Commands

- Bot say hello
- Bot say [something]
- Bot google me [something]
- Bot weather in [City]
- Bot bash me
- Bot deploy branch [branch_name] of [project_name] to [env_name]
- Bot help

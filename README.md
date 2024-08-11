___
# kbot
devops application from scratch

Simple bot for telegram wrote on GO
Used "github.com/spf13/cobra" for generation simple CLI tool on GOlang
and "gopkg.in/telebot.v3" for Telegram messenger bot functionality declaration.

Examples:
t.me/macedonsky777_kbot

After kbot app is started, You can give bot /start command and all messeges what will be written next, will reciaved and shown by bot app.

If You call bot command /start hello, it will say hello to you and return its version.

For usage you need download repo with code and than:
1. gofmt -s -w ./ 
For linting and formatting
2. go build -ldflags "-X="github.com/{username}}/kbot/cmd.appVersion=v1.0.?
Where replace username on your repo username and your app version 
3. read -s TELE_TOKEN
ctrl+v your telegram token
export TELE_TOKEN 
4. ./kbot go 
For launch
___

#!/usr/bin/env sh

case "$1" in
"Messages")
  icon_result=
  ;;
"GitHub Desktop")
  icon_result=
  ;;
"App Store")
  icon_result=
  ;;
"Chromium" | "Google Chrome" | "Google Chrome Canary")
  icon_result=
  ;;
"Color Picker")
  icon_result=
  ;;
"Microsoft Word")
  icon_result=
  ;;
"Neovide" | "MacVim" | "Vim" | "VimR" | "NVim")
  icon_result=
  ;;
"Sublime Text")
  icon_result=
  ;;
"Microsoft PowerPoint")
  icon_result=
  ;;
"Numbers" | "Microsoft Excel")
  icon_result=
  ;;
"Docker" | "Docker Desktop")
  icon_result=󰡨
  ;;
"Default")
  icon_result=󰘔
  ;;
"Firefox" | "Firefox Developer Edition" | "Firefox Nightly")
  icon_result=
  ;;
"Calendar" | "Fantastical")
  icon_result=
  ;;
"Slack")
  icon_result=
  ;;
"Sequel Ace" | "Sequel Pro" | "DataGrip")
  icon_result=
  ;;
"System Preferences" | "System Settings")
  icon_result=
  ;;
"Discord" | "Discord Canary" | "Discord PTB")
  icon_result=󰙯
  ;;
"Vivaldi")
  icon_result=
  ;;
"Skype")
  icon_result=
  ;;
"Canary Mail" | "HEY" | "Mail" | "Mailspring" | "MailMate" | "邮件" | "Thunderbird")
  icon_result=
  ;;
"Safari" | "Safari Technology Preview")
  icon_result=
  ;;
"Keynote")
  icon_result=
  ;;
"Spotify")
  icon_result=
  ;;
"Spotlight")
  icon_result=
  ;;
"Music")
  icon_result=
  ;;
"Eclipse")
  icon_result=
  ;;
"Obsidian" | "Notion" | "Notes")
  icon_result=
  ;;
"Reminders")
  icon_result=
  ;;
"QuickTime Player")
  icon_result=
  ;;
"Preview" | "Skim" | "zathura")
  icon_result=
  ;;
"1Password 7" | "1Password")
  icon_result= # ":one_password:"
  ;;
"Code" | "Code - Insiders")
  icon_result= # ":code:"
  ;;
"Finder")
  icon_result=󰀶 # ":finder:"
  ;;
"Alacritty" | "Hyper" | "iTerm2" | "kitty" | "Terminal" | "WezTerm")
  icon_result= # ":terminal:"
  ;;
"Synergy" | "synergy-core")
  icon_result=⛶
  ;;
"zoom.us" | "Zoom")
  icon_result=󰕧
  ;;
"Font Book")
  icon_result=
  ;;
*)
  icon_result=󰘔
  ;;
esac
echo $icon_result

case "$1" in
"Final Cut Pro")
  icon_result=":final_cut_pro:"
  ;;
"FaceTime")
  icon_result=":face_time:"
  ;;
"Messages" | "Nachrichten")
  icon_result=":messages:"
  ;;
"Thunderbird")
  icon_result=":thunderbird:"
  ;;
"Notes")
  icon_result=":notes:"
  ;;
"GitHub Desktop")
  icon_result=":git_hub:"
  ;;
"App Store")
  icon_result=":app_store:"
  ;;
"Chromium" | "Google Chrome" | "Google Chrome Canary")
  icon_result=":google_chrome:"
  ;;
"zoom.us")
  icon_result=":zoom:"
  ;;
"Color Picker")
  icon_result=":color_picker:"
  ;;
"Microsoft Word")
  icon_result=":microsoft_word:"
  ;;
"Neovide" | "MacVim" | "Vim" | "VimR" | "NVim")
  icon_result=":vim:"
  ;;
"Sublime Text")
  icon_result=":sublime_text:"
  ;;
"Microsoft Excel")
  icon_result=":microsoft_excel:"
  ;;
"Microsoft PowerPoint")
  icon_result=":microsoft_power_point:"
  ;;
"Numbers")
  icon_result=":numbers:"
  ;;
"Default")
  icon_result=":default:"
  ;;
"Firefox Developer Edition" | "Firefox Nightly")
  icon_result=":firefox_developer_edition:"
  ;;
"Firefox")
  icon_result=":firefox:"
  ;;
"Notion")
  icon_result=":notion:"
  ;;
"Live")
  icon_result=":ableton:"
  ;;
"Calendar" | "Fantastical")
  icon_result=":calendar:"
  ;;
"Slack")
  icon_result=":slack:"
  ;;
"Sequel Pro" | "DataGrip")
  icon_result=":sequel_pro:"
  ;;
"System Preferences")
  icon_result=":gear:"
  ;;
"Discord" | "Discord Canary" | "Discord PTB")
  icon_result=":discord:"
  ;;
"Vivaldi")
  icon_result=":vivaldi:"
  ;;
"Skype")
  icon_result=":skype:"
  ;;
"Canary Mail" | "HEY" | "Mail" | "Mailspring" | "MailMate" | "邮件")
  icon_result=":mail:"
  ;;
"Safari" | "Safari Technology Preview")
  icon_result=":safari:"
  ;;
"Keynote")
  icon_result=":keynote:"
  ;;
"Spotify")
  icon_result=":spotify:"
  ;;
"Spotlight")
  icon_result=":spotlight:"
  ;;
"Music")
  icon_result=":music:"
  ;;
"Pages")
  icon_result=":pages:"
  ;;
"Eclipse")
  icon_result=":idea:"
  ;;
"Drafts")
  icon_result=":drafts:"
  ;;
"Obsidian")
  icon_result=":obsidian:"
  ;;
"Reminders")
  icon_result=":reminders:"
  ;;
"Preview" | "Skim" | "zathura")
  icon_result=":pdf:"
  ;;
"1Password 7")
  icon_result=":one_password:"
  ;;
"Code" | "Code - Insiders")
  icon_result=":code:"
  ;;
"Finder")
  icon_result=":finder:"
  ;;
"Alacritty" | "Hyper" | "iTerm2" | "kitty" | "Terminal" | "WezTerm")
  icon_result=":terminal:"
  ;;
"Sequel Ace")
  icon_result=":sequel_ace:"
  ;;
*)
  icon_result=":default:"
  ;;
esac
echo $icon_result

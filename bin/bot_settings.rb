class BotSettings < Settingslogic
  source "#{Rails.root}/config/bot.yml"
  namespace Rails.env
end

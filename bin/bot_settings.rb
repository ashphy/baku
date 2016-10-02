# frozen_string_literal: true
class BotSettings < Settingslogic
  source "#{Rails.root}/config/bot.yml"
  namespace Rails.env
end

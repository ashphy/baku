# frozen_string_literal: true

# Application Global Settings
class BotSettings < Settingslogic
  source Rails.root.join('config', 'bot.yml')
  namespace Rails.env
end

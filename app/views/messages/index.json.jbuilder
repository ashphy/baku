# frozen_string_literal: true

json.array!(@messages) do |message|
  json.extract! message, :id, :text, :user, :command
  json.url message_url(message, format: :json)
end

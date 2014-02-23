json.array!(@channels) do |channel|
  json.extract! channel, :id, :name, :server_id
  json.url channel_url(channel, format: :json)
end

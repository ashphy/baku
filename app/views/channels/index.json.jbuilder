json.array!(@channels) do |channel|
  json.extract! channel, :id, :name, :key, :server_id
  json.url channel_url(channel, format: :json)
end

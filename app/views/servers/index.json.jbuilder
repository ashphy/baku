json.array!(@servers) do |server|
  json.extract! server, :id, :host, :encoding
  json.url server_url(server, format: :json)
end

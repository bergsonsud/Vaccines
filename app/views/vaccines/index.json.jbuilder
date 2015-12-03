json.array!(@vaccines) do |vaccine|
  json.extract! vaccine, :id, :name
  json.url vaccine_url(vaccine, format: :json)
end

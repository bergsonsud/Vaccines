json.array!(@categories) do |category|
  json.extract! category, :id, :name, :age_min, :age_max
  json.url category_url(category, format: :json)
end

json.array!(@maps) do |map|
  json.extract! map, :id, :latitude, :longitude, :name, :formatted_address, :formatted_phone_number, :rating, :url, :website
  json.url map_url(map, format: :json)
end

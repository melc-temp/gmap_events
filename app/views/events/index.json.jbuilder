json.array!(@events) do |event|
  json.extract! event, :id, :event_name, :event_start_date, :event_start_time, :event_end_date, :event_end_time, :event_desc, :text, :map_id, :integer
  json.url event_url(event, format: :json)
end

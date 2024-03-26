json.extract! event, :id, :title, :description, :calendar_id_id, :start_date_time, :end_date_time, :timezone, :location, :created_at, :updated_at
json.url event_url(event, format: :json)

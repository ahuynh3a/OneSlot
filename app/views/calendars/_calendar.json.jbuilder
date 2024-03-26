json.extract! calendar, :id, :owner_id, :title, :description, :created_at, :updated_at
json.url calendar_url(calendar, format: :json)

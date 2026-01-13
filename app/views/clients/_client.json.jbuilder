json.extract! client, :id, :name, :contact_name, :phone, :email, :created_at, :updated_at
json.url client_url(client, format: :json)

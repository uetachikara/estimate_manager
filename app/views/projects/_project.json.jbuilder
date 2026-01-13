json.extract! project, :id, :name, :status, :note, :client_id, :user_id, :created_at, :updated_at
json.url project_url(project, format: :json)

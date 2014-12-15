json.array!(@projects) do |project|
  json.extract! project, :id, :name, :company_id, :default_rate
  json.url project_url(project, format: :json)
end

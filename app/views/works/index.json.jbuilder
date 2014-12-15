json.array!(@works) do |work|
  json.extract! work, :id, :project_id, :user_id, :datetimeperformed, :hours
  json.url work_url(work, format: :json)
end

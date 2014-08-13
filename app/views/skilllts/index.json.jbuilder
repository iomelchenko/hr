json.array!(@skilllts) do |skilllt|
  json.extract! skilllt, :id, :name, :title, :content
  json.url skilllt_url(skilllt, format: :json)
end

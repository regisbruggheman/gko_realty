json.array!(@areas) do |area|
  json.extract! area, :name, :id
end
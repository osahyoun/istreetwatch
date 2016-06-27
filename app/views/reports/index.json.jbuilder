json.array!(@reports) do |report|
  json.extract! report, :lat, :lng, :time, :description, :summary
end

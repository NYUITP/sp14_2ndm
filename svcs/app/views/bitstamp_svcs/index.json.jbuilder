json.array!(@bitstamp_svcs) do |bitstamp_svc|
  json.extract! bitstamp_svc, :id
  json.url bitstamp_svc_url(bitstamp_svc, format: :json)
end

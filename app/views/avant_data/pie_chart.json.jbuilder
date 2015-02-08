json.array! @count_data do |type, count|
  #TODO hard coded filter
  next if type == -99
  next if type == "Data Unavailable"
  json.key type
  json.y count
end
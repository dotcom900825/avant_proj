json.array! @data do |kv|
  json.value kv[0]
  json.size kv[1]
end
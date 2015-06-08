json.nodes do 
  json.array! @data do |data|
    json.name data.loc_res_city
    json.cluster data.cluster_id
  end
end
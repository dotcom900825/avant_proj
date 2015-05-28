json.array! @grouped_data do |group|
  json.key group
  json.values do 
    json.array! @data.where(@group_by=>group) do |data|
      json.series 0
      json.shape "circle"
      json.size (data.send @size_param) || 1
      json.x (data.send @x_param) || 0
      json.y (data.send @y_param) || 0
    end
  end

end
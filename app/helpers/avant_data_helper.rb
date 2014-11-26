module AvantDataHelper
  def recursive_builder(json, query1, query2)
    json.name = "AvantGarde"
    json.children do 
      diff_values = AvantData.pluck(query1.to_sym).uniq.reject! {|c| c.blank? || c.empty?}
      json.array! diff_values do |val|
        json.name val
        json.children do 
          json.array! AvantData.where(query1.to_sym=>val).pluck(query2.to_sym).uniq.reject! {|c| c.blank? || c.empty?} do |val2|
            json.name val2
            json.size AvantData.where(query1.to_sym=>val, query2.to_sym=>val2).count
          end 
        end
      end
    end
  end
end

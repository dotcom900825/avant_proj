module AvantDataHelper
  def recursive_builder(json, query1, query2)
    json.name "Root"
    json.children do 
      diff_values = SdtjDemo.pluck(query1.to_sym).uniq.reject! {|c| c.blank? || c.empty?}
      json.array! diff_values do |val|
        collection = SdtjDemo.where(query1.to_sym=>val).pluck(query2.to_sym).uniq.reject! {|c| c.blank? || c.empty?}
        if collection.present?
          json.name val
          json.children do 
            json.array! SdtjDemo.where(query1.to_sym=>val).pluck(query2.to_sym).uniq.reject! {|c| c.blank? || c.empty?} do |val2|
              json.name val2
              json.size SdtjDemo.where(query1.to_sym=>val, query2.to_sym=>val2).count
            end 
          end
        end
      end
    end
  end

  def recursive_builder2(json, query1, query2, query3)
    json.name "Root"
    json.children do
      diff_values = SdtjDemo.pluck(query1.to_sym).uniq.reject! {|c| c.blank? || c.empty?}

      json.array! diff_values do |val|
        collection = SdtjDemo.where(query1.to_sym=>val).pluck(query2.to_sym).uniq.reject! {|c| c.blank? || c.empty?}
        
        if collection.present?
          json.name val
          json.children do 
            json.array! collection do |val2|
              collection2 = SdtjDemo.where(query1.to_sym=>val, query2.to_sym=>val2).pluck(query3.to_sym).uniq.reject! {|c| c.blank? || c.empty?}
              if collection2.present?
                json.name val2
                json.children do
                  json.array! collection2 do |val3|
                    json.name val3
                    json.size SdtjDemo.where(query1.to_sym=>val, query2.to_sym=>val2, query3.to_sym=>val3).count
                  end
                end
              end
            end 
          end
        end

      end

    end
  end

end



require "area"

task :load_geo_info => :environment do
  SdtjDemo.all.each do |data|

    begin
      if data.zip.present?
        lat = data.zip.to_lat
        long = data.zip.to_lon
        if lat && long
          data.lat = lat
          data.long = long
          data.save
        end
      end  
    rescue Exception => e
      
    end

  end

end
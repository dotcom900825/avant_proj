require "openssl"
require "geokit"

task :update_state_city => :environment do
  AvantData.all.each do |data|
    if data.zip.present?
      loc = Geokit::Geocoders::MultiGeocoder.geocode(data.zip) 
      data.residence_city = loc.city
      data.residence_state = loc.state_code
      data.save
    end

  end
end
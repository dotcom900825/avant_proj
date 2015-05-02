require "csv"

task :load_packet_data => :environment do
  counter = 0

  CSV.foreach(File.expand_path('../packet.csv', __FILE__)).each do |row|
    WifiData.create(:time=>row[1], :source=>row[2], :destination=>row[3], :protocol=>row[4], :length=>row[5], :info=>row[6])
    counter += 1
    break if counter == 2000
  end
end
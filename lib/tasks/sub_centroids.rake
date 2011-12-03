task :sub_centroids => :environment do
  csv = FasterCSV.open("#{Rails.root.to_s}/db/initial/centroids.csv", :headers => true).each do |row|
    next if row.header_row?
      s = Station.find(:division => row['division'], :station_name => row['station_name'], :line => row['line'])[0]
      s.latitude  = row['lat']
      s.longitude = row['lng']
      s.save
      p s
  end
end
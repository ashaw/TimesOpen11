task :stations => :environment do
  latlng_re = /(^[\d]{2}|^[-\d]{3})(\d+$)/

  csv = FasterCSV.open("#{Rails.root.to_s}/db/initial/StationEntrances.csv", :headers => true).each do |row|
    next if row.header_row?
    station = Station.new
    station.division     = row['Division']
    station.line         = row['Line']
    station.station_name = row['Station_Name']
    station.route_1      = row['Route_1']
    station.route_2      = row['Route_2']
    station.route_3      = row['Route_3']
    station.route_4      = row['Route_4']
    station.route_5      = row['Route_5']
    station.route_6      = row['Route_6']
    station.route_7      = row['Route_7']
    station.route_8      = row['Route_8']
    station.route_9      = row['Route_9']
    station.route_10     = row['Route_10']
    station.route_11     = row['Route_11']
    station.corner       = row['Corner']
    station.latitude     = row["Latitude"].gsub(latlng_re, '\1.\2')
    station.longitude    = row["Longitude"].gsub(latlng_re, '\1.\2')
    station.save
    p station
  end
end

task :cache_happiness => :environment do

  Station.all.each do |station|
    happy, sad, total = station.get_happiness
    station.happiness_index = happy / total
    station.save!
  end

end


task :centroids => :environment do
  csv = FasterCSV.open("#{Rails.root}/db/initial/centroids.csv", :headers => true).each do |row|
    station = Station.where(:line => row['line'], :division => row['division'], :station_name => row['station_name']).first

    station.latitude = row['lat']
    station.longitude = row['lng']
    puts station.inspect unless station.save
  end

end

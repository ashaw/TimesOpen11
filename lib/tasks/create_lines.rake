# run this after importing stations
task :create_lines => :environment do
  Station.all_entrances.each do |station|
    1.upto(11).each do |r|
      if station.send("route_#{r}")
        line = Line.find_or_create_by_name(station.send("route_#{r}"))
        line.stations << station
        station.save
      end
    end
  end
end
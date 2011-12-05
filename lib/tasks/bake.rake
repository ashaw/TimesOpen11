task :bake => :environment do
  `curl http://localhost:3030`
  
  Line.all.each do |line|
    `curl http://localhost:3030/lines/#{line.name}`
  end
end
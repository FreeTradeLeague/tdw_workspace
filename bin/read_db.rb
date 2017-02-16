require "sqlite3"

DATADIR = File.expand_path("../../data", __FILE__)
data_file = DATADIR + "/tdw.db"
db = SQLite3::Database.new(data_file)

fields = Array.new
has_fields = false

rows = db.execute("SELECT * FROM people_1416 LIMIT 1")
rows[0].fields.each do |f|
  fields << f
end

rows = db.execute("SELECT * FROM people_1416 WHERE name LIKE '%Marco%' LIMIT 1") do |row|
  ind = 0
  row.each do |r|
    puts "#{fields[ind].capitalize}: #{r}"
    ind += 1
  end
end

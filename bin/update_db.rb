require "sqlite3"

DATADIR = File.expand_path("../../data", __FILE__)
data_file = DATADIR + "/tdw.db"
db = SQLite3::Database.new(data_file)

options = { "id" => 3, "name" => "CPT Marco Domici", "upp" => "78BAFC"}
id    = options["id"]
name  = options["name"]
upp   = options["upp"]
statement = db.prepare "UPDATE people_1416 SET name = ?, upp = ? WHERE id = ?"
statement.bind_params name, upp, id
results = statement.execute
row     = results.next
puts row    
statement.close if statement
db.close if db

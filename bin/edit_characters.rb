require "sqlite3"
require "tk"

options = Hash.new(0)

def pull_character(options)

  datadir = File.expand_path("../../data", __FILE__)
  data_file = datadir + "/tdw.db"
  db = SQLite3::Database.new(data_file)

  fields = Array.new
  has_fields = false

  rows = db.execute("SELECT * FROM people_1416 WHERE name LIKE '%Marco%' LIMIT 1") do |row|
    options["id"]    = row[0]
    options["name"]  = row[1]
    options["upp"]   = row[3]
  end
  db.close()
end

def save_character(options)
  begin 
    datadir = File.expand_path("../../data", __FILE__)
    data_file = datadir + "/tdw.db"
    db = SQLite3::Database.new(data_file)
    id    = options["id"]
    name  = options["name"]
    upp   = options["upp"]
    statement = db.prepare "UPDATE people_1416 SET name = ?,upp = ? WHERE id = ?"
    statement.bind_params name, upp, id
    #statement.bind_params(options["name"], options["id"])
    results = statement.execute
    #db.execute("UPDATE people_1416 SET name = ?, upp = ? WHERE id = ?",
    #  options["name"], options["upp"], options["id"])
    run = results.next
 
    rows = db.execute("SELECT * FROM people_1416 WHERE name LIKE '%Marco%' ") do |row|
      options["id"]    = row[0]
      options["name"]  = row[1]
      options["upp"]   = row[3]
    end
    puts "#{options['upp']}"
    statement.close if statement
    db.close if db
  rescue SQLite3::Exception => e
    puts e.to_s
  end
end

def open_edit_window(options)
  def packing(padx, pady, side=:left, anchor=:n) {
    "padx" => padx, "pady" => pady,
    "side" => side.to_s, "anchor" => anchor.to_s}
  end

  root  = TkRoot.new() { title "Edit Character" }
  top   = TkFrame.new(root)
  name_frame  = TkFrame.new(top)
  upp_frame   = TkFrame.new(top) 

  label_pack   = packing(5, 5, :left, :center)
  entry_pack   = packing(5, 2, :left, :center)
  frame_pack   = packing(2, 2, :top, :center)

  options["var_name"]    = TkVariable.new(options["name"])
  options["var_upp"]     = TkVariable.new(options["upp"])
  
  label_name  = TkLabel.new(name_frame) do
    text "Name"
    pack label_pack
  end
  entry_name  = TkEntry.new(name_frame) do
    textvariable  options["var_name"]
    font "{Arial} 12"
    pack entry_pack
  end

  label_name  = TkLabel.new(upp_frame) do
    text "Upp"
    pack label_pack
  end
  entry_name  = TkEntry.new(upp_frame) do
    textvariable options["var_upp"]
    font "{Arial} 12"
    pack entry_pack
  end

  top.pack  frame_pack
  name_frame.pack frame_pack
  upp_frame.pack  frame_pack

  #var_name.value  = options["name"]
  #var_upp.value   = options["upp"]
end 
  
def open_search_window(options)

  def packing(padx, pady, side=:left, anchor=:n) {
    "padx" => padx, "pady" => pady,
    "side" => side.to_s, "anchor" => anchor.to_s}
  end
 
  search_name   = TkVariable.new
 
  label_pack    = packing(5, 5, :left, :w)
  entry_pack    = packing(5, 5, :left)
 
  label_name    = TkLabel.new() do
    text "Search for (name):"
    pack label_pack
  end
  entry_name    = TkEntry.new() do
    width 21 
    textvariable search_name
    font "{Arial} 12"
    pack entry_pack
  end   
end 

def set_buttons(options)
  def packing(padx, pady, side=:left, anchor=:n) {
    "padx" => padx, "pady" => pady,
    "side" => side.to_s, "anchor" => anchor.to_s}
  end
 
  button_pack   = packing(15, 5, :left, :center)
  button_save   = TkButton.new() do
    text "Save Changes?"
    command {save_character(options)}
    pack button_pack
  end
  button_exit   = TkButton.new() do
    text "Exit"
    command proc  {exit}
    pack button_pack
  end
end

#open_search_window(options)
pull_character(options)
open_edit_window(options)
set_buttons(options)
Tk.mainloop

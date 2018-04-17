import sqlite3

gotten_names = []

conn = sqlite3.connect('../data/tdw.db')

people_file = open('people_1416.cypher', 'w')
people_file.write("begin\n")
people_file.write("commit\n")
people_file.write("begin\n")
c = conn.cursor()
c.execute("SELECT * FROM people_1416")
rows = c.fetchall()
for row in rows:
  if row[1] in gotten_names:
    continue
  else:
    name_key = row[1].replace(" ", "").replace("\"", "").replace(",","")
    gotten_names.append(row[1])
    people_file.write("create (%s:Person {id:%d, name:'%s'})\n" % (name_key, row[0], row[1]))

conn.commit()
conn.close()

people_file.write(";\n")
people_file.write("commit\n")

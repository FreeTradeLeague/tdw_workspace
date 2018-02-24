class Crew
  def initialize(crew_number)
    @crew = []
    crew_number.times do 
      ncp     = Character.new 
      career  = ["Merchant", "Navy"].sample
      terms   = rand(1..3)
      new_crewperson(career, terms, ncp)
      @crew << ncp
    end
  end
  def show_crew
    counter = 1
    @crew.each do |c|
      print("Crewperson #%d is %d years old. Former %s, UPP: %s.\n" %
        [counter, c.age, c.career, c.upp]) 
      counter += 1
    end
  end
  def new_crewperson(career,terms,ncp)
    if career == "Merchant"
      Merchant.new(ncp, terms)
    elsif career == "Navy"
      Navy.new(ncp, terms)
    end
  end    
end
       
class Character
  attr_accessor  :age, :career, :name, :upp
  def initialize
    @age = 14
  end
end

class Career
  def initialize(char, terms = 1)
    @char   = char
    @terms  = terms
    run_career
  end
  def run_career
    @char.age += @terms * 4
  end
end

class Merchant < Career
  def run_career
    super()
    @char.upp = "777888"
    @char.career = self.class.to_s
  end
end

class Navy < Career
  def run_career
    super()
    @char.upp = "777777"
    @char.career = self.class.to_s
  end
end

### Actually do stuff
my_crew = Crew.new(6)
my_crew.show_crew

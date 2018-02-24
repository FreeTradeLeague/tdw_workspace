class Character
  attr_accessor  :age, :career, :name, :upp
end

class Career
  def initialize(char = nil, terms = 1)
    @char   ||= gen_char(char)
    @terms  = terms
    run_career
  end
  def gen_char(char)
    puts "In gen_char char.class is #{char.class}."
    if char
      puts "In if char"
      @char = char
      #puts @char.age.class
      #puts @char.age
    else
      puts "In else char"
      @char = Character.new
      @char.name  = "Ian"
      @char.age   = 12
      #puts @char.age.class
    end
  end
  def run_career
    puts "in run_career, char.age is #{@char.age}."
    puts "terms.class is #{@terms.class}."
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

class Citizen < Career
  def run_career
    super()
    @char.upp = "777777"
    @char.career = self.class.to_s
  end
end

fred = Character.new
fred.age = 18
puts fred.age

Citizen.new(fred, 2)
puts fred.age
puts fred.upp
puts fred.career
puts fred.career.class

joe = Merchant.new
puts joe.age
puts joe.upp
puts joe.career

require_relative 'modules/company'

class Carriage

  include Company  

  attr_reader :type 
  attr_accessor :number_of_units, :number
  
  def initialize(type, number_of_units)
    @number = rand(1..1000)      
    @type = type
    @number_of_units = number_of_units
  end 
 
  def take_a_unit(value = 1)
    if @number_of_units > 0 
      @number_of_units -= value
    else
      puts "Units ended."
    end  
  end 
  
  def occupied_units
    @total_units - @number_of_units
  end
end  





  
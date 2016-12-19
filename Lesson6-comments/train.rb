require_relative 'modules/instance_counter'
require_relative 'modules/company'

class Train
  include InstanceCounter
  include Company

  attr_accessor :number, :type, :speed, :set_route, :moving_to_the_next_station, :route, :carriages

  TRAIN_NUMBER = /^[a-zA-Z0-9]{3}.*\w{2}\z/i

  @@trains_list = {}

  def initialize(number)
    @number = number 
    @speed = 0
    @carriages = []
    add_train_to_train_list
    register_instance
    validate!
  end
  
  def add_train_to_train_list
    if  @@trains_list.key?(number) 
      puts "Train with this number already exists."
    else
      @@trains_list[number] = self
    end   
  end  
  
  def valid?
    validate!
  rescue
    false  
  end 
  
  def to_s
    "Train type: #{@type}, number: #{@number}" 
  end  

  def moving_to_the_next_station(station_from, station_to)  
    self.speed_up(80) if @speed.zero?
    puts "Speed: #{self.speed}"

    @station_index = @route.station_index(station_to)

    puts "The train arrived at the station: #{self.current_station}"
    
    if @current_station != @route.last_station
      station_to.take_a_train(self) 
    else
      puts "The train at the last station." 
    end   

    if @current_station != @route.route.first
      station_from.send_train(self)
    else
      puts "The train to the first station."  
    end  
  end 

  def current_station
    @route.route_station(@station_index)
  end  

  def previous_station
    @route.route_station(@station_index - 1) 
  end  

  def next_station
    @route.route_station(@station_index + 1)  
  end 

  def set_route(route)
    @route = route
  end

  def speed_up(speed)
    if speed < 0 
      puts "Error. The speed is a negative value."
    elsif  speed < 100 
      @speed = speed
      puts "Speed: #{@speed}" 
    else
      puts "The train can not go so fast!"
    end    
  end
  
  def stop
    @speed = 0
    puts "The train stopped." 
  end  

  def add_carriage(carriage)
    if carriage.type == self.type
      @carriages.push(carriage)
    else
      puts "It's impossible. The train moves or train type does not match the type of the carriage"
    end    
  end  

  def del_carriage
    if @speed.zero? && @carriages.count > 0 
      @carriages.pop
      puts "Carriage  detached"
    else  
      puts "It's impossible. The train is moving or wagons left."
    end  
  end  

  def self.find(number)
    @@trains_list[number]
  end
  
  def self.all
    @@trains_list
  end 

private

  def validate!
    raise "Train number should be of the form (XXX-XX)" if number !~ TRAIN_NUMBER
  end
end
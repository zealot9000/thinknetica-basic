require_relative 'modules'

class Station
  include InstanceCounter
  
  attr_accessor :name, :list_trains 

  @@station_list = []

  def initialize(name)
    @name = name
    @list_trains = []
    @@station_list << self
  end  
 
  def trains_type
    @list_trains.each { |train| puts "#{train.type} - №#{train.number}" }
  end

  def take_a_train(train)
    @list_trains << train
  end 

  def send_train(train)
    @list_trains[train.type.to_sym].delete(train)
  end   
  
  def self.all
    @@station_list
  end  
  
end 



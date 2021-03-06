require_relative 'modules/instance_counter'
require_relative 'modules/valid'

class Station
  include InstanceCounter
  include Valid
  
  attr_accessor :name, :list_trains

  NAME_FORMAT = /^[a-zA-Zа-яА-Я0-9]$/

  @@station_list = []

  def initialize(name)
    @name = name
    @list_trains = []
    validate!
    @@station_list << self
    register_instance
  end  

  class << self
    def all
      @@station_list
    end  
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

protected
  
  def validate!
    raise "Station Name should be longer than two characters." if name.length < 2
    raise "Station name must consist of letters." if name !~ NAME_FORMAT
  end     
  
end 
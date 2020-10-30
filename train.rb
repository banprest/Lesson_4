class Train
  attr_accessor :speed

  attr_reader :railcar, :type, :current_station, :number

  def initialize(number)
    @number = number
    @railcar = []
    @speed = 0
  end

  def stop
    self.speed = 0
  end

  def add_train_to_route(way)
    @way = way
    @current_station = way.starting_station
    @current_station.add_train(self)
  end

  def move_forward
    @current_station.delete_train(self)
    @current_station = next_station 
    @current_station.add_train(self)   
  end

  def move_back
    @current_station.delete_train(self)
    @current_station = previous_station 
    @current_station.add_train(self)
  end

  def next_station
    return if @current_station == @way.terminal_station
    @way.route[@way.route.index(current_station) + 1]
  end

  def previous_station
    return if @current_station == @way.starting_station
    @way.route[@way.route.index(current_station) - 1]
  end

  def delete_railcar(railcar)
    @railcar.delete(railcar)
  end

  protected
  attr_writer :current_station

  def add_railcar(railcar)
    @railcar << railcar
  end
end
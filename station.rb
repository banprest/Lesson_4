class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    @trains << train
  end

  def list_of_trains_by_type(type)
    @trains.select { |train| train.type == type }
  end

  def delete_train(train)
    @trains.delete(train)
  end
end
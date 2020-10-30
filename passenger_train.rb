class PassengerTrain < Train 

  def its_passenger_train?(railcar)
    railcar.type == :passenger
  end

  def add_passenger_railcar(railcar)
    add_railcar(railcar) if its_passenger_train?(railcar)
  end
end
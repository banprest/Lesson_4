class CargoTrain < Train

  def its_cargo_train?(railcar)
    railcar.type == :cargo
  end

  def add_cargo_railcar(railcar)
    add_railcar(railcar) if its_cargo_train?(railcar)
  end
end
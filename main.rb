require_relative 'route.rb'
require_relative 'station.rb'
require_relative 'train.rb'
require_relative 'cargo_train.rb'
require_relative 'passenger_train.rb'
require_relative 'cargo_railcar.rb'
require_relative 'passenger_railcar.rb'

class Main
  attr_reader :stations, :routes, :trains

  def initialize
    @stations = []
    @routes = []
    @trains = []
  end

  def create_station(station)
    @stations << Station.new(station)
  end

  def create_route(starting_station, terminal_station)
    @routes << Route.new(@stations[starting_station], @stations[terminal_station])
  end

  def create_train(id, type)
    if type == :passenger
      @trains << PassengerTrain.new(id)
    elsif type == :cargo
      @trains << CargoTrain.new(id)
    else 
      return nil
    end
  end

  def create_railcar
    type = gets.chomp.to_sym
    if type == :passenger
      PassengerRailcar.new
    elsif type == :cargo
      CargoRailcar.new
    else 
      return nil
    end
  end

  def add_station_to_route(number_route, number_station)
    @routes[number_route].add_station(@stations[number_station])
  end

  def delete_station_to_route(number_route, number_station)
    @routes[number_route].delete_station(@stations[number_station])
  end

  def add_train_to_road(num_train, num_road)
    @trains[num_train].add_train_to_route(@routes[num_road])
  end

  def move_train_forward(num_train)
    @trains[num_train].move_forward
  end

  def move_train_back(num_train)
    @trains[num_train].move_back
  end

  def add_railcar_to_train(num_train)
    railcar = create_railcar
    if railcar.type == :cargo
      @trains[num_train].add_cargo_railcar(railcar)
    elsif railcar.type == :passenger
        @trains[num_train].add_passenger_railcar(railcar)
    else
      return nil
    end
  end

  def delete_railcar_to_train(num_train)
    @trains[num_train].delete_railcar(@trains[num_train].railcar.last)
  end

  def show_station
    @stations.each_with_index do |station, num|
      puts "#{station.name} #{num}"
    end
  end

  def show_route
    @routes.each_with_index do |route, num|
      puts "#{route} #{num}"
    end
  end

  def show_train
    @trains.each_with_index do |id_train, num|
      puts "#{id_train.number} #{num}"
    end
  end

  def sett
    create_station('moscva')
    create_station('piter')
    create_route(0, 1)
    create_train(321, :cargo)
    create_train(412, :passenger)
    info_station(0)
  end
end

main = Main.new

loop do
  puts 'Для создания станции введите - 0.
  Для создания поезда введите - 1.
  Для создания маршрута введите 2.
  Для того чтобы добавить станцию к маршруту введите 3.
  Для того чтобы удалить станцию из маршрута введите 4.
  Для того чтобы назаначить маршрут поузду введите 5.
  Для того чтобы добавить вагон к поезду введите 6.
  Для того чтобы отцепить вагон от поезда введите 7.
  Для того чтобы переместить поезд вперед введите 8.
  Для того чтобы переместить поезд назад введите 9.
  Чтобы просмотреть список станций введите 10.
  Чтобы просмотреть список поездов введите 11. '

  choise = gets.chomp

  case choise
  when '0'
    puts 'Введите название станции'
    station = gets.chomp
    main.create_station(station)
  when '1'
    puts 'Введите номер, и тип к которому он принадлежит "passenger" или "cargo"'
    id = gets.chomp.to_i
    type = gets.chomp.to_sym
    main.create_train(id, type)
  when '2'
    main.show_station
    puts 'Введите номер начальной станции'
    starting_station = gets.chomp.to_i
    puts 'Введите номер конечной станции'
    terminal_station = gets.chomp.to_i
    main.create_route(starting_station, terminal_station)
  when '3'
    main.show_route
    main.show_station
    puts 'Введите номер уже созданых маршрута и станции'
    route = gets.chomp.to_i
    station = gets.chomp.to_i
    main.add_station_to_route(route, station)
  when '4'
    main.show_route
    main.show_station
    puts 'Введите номер уже созданых маршрута и станции'
    route = gets.chomp.to_i
    station = gets.chomp.to_i
    main.delete_station_to_route(route, station)
  when '5'
    main.show_train
    main.show_route
    puts 'Введите номер уже созданых поезда и маршрута'
    train = gets.chomp.to_i
    route = gets.chomp.to_i
    main.add_train_to_road(train, route)
  when '6'
    main.show_train
    puts 'Введите номер поезда'
    train = gets.chomp.to_i
    puts 'Введите тип вагона "passenger" или "cargo"'
    main.add_railcar_to_train(train)
  when '7'
    main.show_train
    puts 'Введите номер поезда'
    train = gets.chomp.to_i
    main.delete_railcar_to_train(train)
  when '8'
    main.show_train
    puts 'Введите номер уже сущесствующего поезда'
    train = gets.chomp.to_i
    main.move_train_forward(train)
  when '9' 
    main.show_train
    puts 'Введите номер уже сущесствующего поезда'
    train = gets.chomp.to_i
    main.move_train_back(train)
  when '10'
    main.show_station
  when '11'
    main.show_train
  else 
    puts 'EROR'
  end
puts 'Чтобы выйти из текстового интерфейса введите "да"'
break_say = gets.chomp
break if break_say == 'да'
end
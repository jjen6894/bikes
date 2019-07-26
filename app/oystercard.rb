require_relative 'journey'

class Oystercard
  attr_accessor :balance, :exit_station, :visited, :in_journey, :entry_station

  MAX_BALANCE=90

  def initialize
    @balance = 0
    @in_journey = Journey.new(entry_station: nil)
    @entry_station = nil
    @visited = []
    @exit_station = nil
    @state = nil
  end


  def top_up(amount)
    if (@balance + amount) <= MAX_BALANCE
      @balance += (amount)
    else
      return @balance
    end
  end

  def deduct(fare)
    real_fare=fare.abs
    if (@balance - real_fare) >= 0
      @balance -= real_fare
    else
      return @balance
    end
  end

  def journey
    @in_journey.complete?
  end

  def touch_in(station)
    if @state === "in"
      @balance = @balance - 10
      return 'penalty'

    else
      @state = "in"
      @previous_station = station

      if @balance < 0
        @in_journey = Journey.new(entry_station: nil)
      else
        assign_station(station)
      end
    end
  end

  def touch_out(station)
    @state = 'out'
    if station === @previous_station
      return 'error same station'
    end
    fare = calculate_fare(station)
    if @balance > fare
      return 'error no money'
    end
    visit_time(fare, station)
  end

  private

  def assign_station(station)
    time_now = Time.now
    if @entry_station
      @entry_station = nil
      @exit_station = (station)
      @exit_station.visited_time = time_now
    else
      @entry_station = (station)
      @entry_station.visited_time = time_now
    end
    @in_journey.entry_station = @entry_station
  end

  def calculate_fare(station)
    entry_station_zone = @entry_station.zone
    exit_station_zone = station.zone
    fare = entry_station_zone - exit_station_zone
    if fare == 0
      fare = 1
    end
    fare
  end

  def visit_time(fare, station)
    unless @in_journey.complete?
      assign_station(station)
      deduct(fare)
      @in_journey.finish(@exit_station)
      @visited.push(@in_journey)
    end
  end

end






class Journey
  attr_accessor :zone, :name, :in_journey, :fare,
                :station, :entry_station, :other_station,
                :balance, :top_up, :amount

  PENALTY_FARE = 6

  def initialize(entry_station: entry_station)
    @entry_station = entry_station
    @exit_station = nil
  end


  def fare
    if @entry_station && @exit_station
      return 1
    else
      PENALTY_FARE
    end
  end

  def finish(exit_station)
    @exit_station = exit_station
    return self
  end

  def complete?
    @entry_station && @exit_station
  end
end

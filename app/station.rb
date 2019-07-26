class Station
  attr_accessor :zone, :name, :visited_time

  def initialize(zone, name)
    @zone = zone
    @name = name
    @visited_time = nil
  end
end

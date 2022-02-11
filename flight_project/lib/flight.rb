require_relative "passenger"

class Flight
    attr_reader :passengers
    def initialize(flight_number,capacity)
        @flight_number = flight_number
        @capacity = capacity
        @passengers = []
    end

    def full?
        self.passengers.length == @capacity
    end

    def board_passenger(passenger)
        self.passengers << passenger if passenger.has_flight?(@flight_number) && !full?
    end

    def list_passengers
        self.passengers.map {|el| el.name}
    end
    
    def [](index)
        self.passengers[index]
    end

    def <<(passenger)
        board_passenger(passenger)
    end
end
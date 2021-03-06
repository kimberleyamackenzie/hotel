require 'date'

class Hotel
  attr_accessor :rooms, :roominfo

  def initialize
    @rooms = []

    id = 1
    20.times do
      @rooms << Room.new(id)
      id += 1
    end

    @roominfo = []
    @rooms.each do |room|
      id = room.id
      status = room.status
      @roominfo << {id => status}
    end
  end

  def list
    return @rooms
  end

end # end of class

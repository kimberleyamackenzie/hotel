require_relative 'reservations'
require 'date'

class Block
attr_reader :total_cost, :block_id, :blocked_rooms, :checkin_date, :checkout_date
@@every_block = []


  def initialize(room_count, startyear, startmonth, startday, endyear, endmonth, endday, block_id)
    if room_count > 5 || room_count.class != Integer || room_count < 2
      raise ArgumentError.new("Rooms must be blocked in quantities between 2 and 5.")
    end

    @block_id = block_id
    @blocked_rooms = Availability.all_available_rooms(startyear, startmonth, startday, endyear, endmonth, endday)[0...room_count]



    @checkin_date = Date.new(startyear,startmonth,startday)
    @checkout_date = Date.new(endyear,endmonth,endday)

    wanteddate = checkin_date

  # blocked_rooms.each do |room|
    until wanteddate == checkout_date
      Availability.calendar.each do |days|
        days.each do |date, roominfo|
          if wanteddate == date
            roominfo.each do |rooms|
              rooms.each do |id, status|
                if blocked_rooms.include?(id)
                # if id == room_id
                  rooms[id] = :blocked
                end
              end
            end
          end
        end
      end
      wanteddate += 1
    end
  # end


    # @@blockinfo << [self.block_id, self.blocked_rooms, self.checkin_date, self.checkout_date]

    @@every_block << self




    total_stay = (@checkout_date - @checkin_date).to_i
    @total_cost = total_stay * 175

    return @blocked_rooms

  end

  def self.all_blocks
    return @@every_block
  end

end # end of class

require 'date'
shifts = File.open('guard_shift_times.txt').map do |str|
  match = str.match(/\[(.*)\].*?(up|asleep|\d+)/)
  [DateTime.parse(match[1]), match[2]]
end.sort

# hash = Hash.new(0)
# current_guard = nil
# sleep_minute = nil

# pp shifts.each do |shift|
#   if shift[1] == 'asleep'
#     sleep_minute = shift[0]
#   elsif shift[1] == 'up'
#     awake_minute = shift[0]
#     (sleep_minute..awake_minute).each do |minute|
#       hash[current_guard][minute] += 1 
#     end
#   else
#     current_guard ||= 0
#   end 
# end

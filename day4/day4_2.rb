require 'date'
shifts = File.open('guard_shift_times.txt').map do |str|
  match = str.match(/\[(.*)\].*?(up|asleep|\d+)/)
  [DateTime.parse(match[1]), match[2]]
end.sort

hash = Hash.new
current_guard = nil
sleep_minute = nil

shifts.each do |shift|
  if shift[1] == 'asleep'
    sleep_minute = shift[0].minute
  elsif shift[1] == 'up'
    hash[current_guard] ||= Hash.new(0)
    awake_minute = shift[0].minute
    (sleep_minute..awake_minute-1).each do |minute|
    hash[current_guard][minute] += 1
    end
  else
    current_guard = shift[1]
  end 
end

most_sleep_per_guard = hash.map {|guard| [guard.first, guard.last.max_by{|k,v| v}]}.to_h
guard_sleep_info = most_sleep_per_guard.rassoc(most_sleep_per_guard.values.max_by{|k,v| v}).flatten

p "guard #{guard_sleep_info[0]} slept at 00:#{guard_sleep_info[1]} #{guard_sleep_info[2]}times. So the solution is: #{guard_sleep_info[0].to_i * guard_sleep_info[1]}"

require 'date'
require 'byebug'
shifts = File.open('guard_shift_times.txt').map do |str|
  match = str.match(/\[(.*)\].*?(up|asleep|\d+)/)
  [DateTime.parse(match[1]), match[2]]
end.sort

sleeptime = {}
current_guard = nil
sleep_minute = nil

shifts.each do |shift|
  case shift[1]
  when 'asleep'
    sleep_minute = shift[0].minute
  when 'up'
    minutes_slept = shift[0].minute - sleep_minute
    sleeptime[current_guard] += minutes_slept
  else
    current_guard = shift[1]
    sleeptime[current_guard] ||= 0
  end
end

sleepy_guard = sleeptime.rassoc(sleeptime.values.max)[0]

sleep_minutes = Hash.new(0)
is_sleepy_guard = false

shifts.each do |shift|
  case shift[1]
  when 'asleep'
    next unless is_sleepy_guard
    sleep_minute = shift[0].minute
  when 'up'
    next unless is_sleepy_guard
    awake_minute = shift[0].minute
    (sleep_minute..awake_minute).each { |minute| sleep_minutes[minute] += 1 }
  else
    is_sleepy_guard = shift[1] == sleepy_guard
  end
end

most_slept_minute = sleep_minutes.rassoc(sleep_minutes.values.max)[0]

p "The sleepiest guard has the id: #{sleepy_guard}. His favorie minute to sleep in is OO:#{most_slept_minute}. So the solution is #{most_slept_minute * sleepy_guard.to_i}"
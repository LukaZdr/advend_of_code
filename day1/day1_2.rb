require 'set'
frequencys = File.open('frequencys.txt').map(&:to_i)
result = 0
set = Set.new
dup = nil
while dup == nil do
  frequencys.each do |int|
    result += int
    if set.include?(result)
      dup = result
      break
    end
    set.add(result)
  end
end
p dup
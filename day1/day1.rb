f = File.readlines('frequencys.txt').map(&:to_i)
p f.sum
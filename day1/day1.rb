f = File.read('frequencys.txt').map(&:to_i)
p f.inject(0, &:+)
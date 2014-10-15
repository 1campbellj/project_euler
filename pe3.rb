target = 600851475143
list = []
max_factor = 1
f = File.open('/Users/josephc/projects/project_euler/files/primes1.txt')
f.each_line do |line|
  list = line.split(/\s/)
  list.each do |n|
    begin
      if n.to_i > 0
        if target%n.to_i == 0
          puts n
          max_factor = n.to_i
        end
      end
    rescue
      puts "error " + list
    end
  end
end
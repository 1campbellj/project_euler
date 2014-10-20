results = []

(0..200).each do |a|
  (0..100).each do |b|
    (0..40).each do |c|
      (0..20).each do |d|
        (0..10).each do |e|
          (0..4).each do |f|
            (0..2).each do |g|
              sum = a + 2*b + 5*c + 10*d + 20*e + 50*f + 100*g
              
              if sum == 200
                puts [a, b, c, d, e, f, g, sum].to_s
                results += [a]
              end
            end
          end
        end
      end
    end
  end
end
puts results.length
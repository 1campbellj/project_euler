##If we list all the natural numbers below 10 that are multiples of 3 or 5, #we get 3, 5, 6 and 9. The sum of these multiples is 23.

#Find the sum of all the multiples of 3 or 5 below 1000.#


def sum_multiples_3and5(k)
  return nil unless k.class == Fixnum
  answer = 0
  (1..k).each do |n|
    if n%3 == 0 || n%5 == 0
      answer += n
    end
  end
  return answer
end

puts sum_multiples_3and5(999)
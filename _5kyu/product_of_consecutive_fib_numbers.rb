# The Fibonacci numbers are the numbers in the following integer sequence (Fn):

# 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, ...
# such as

# F(n) = F(n-1) + F(n-2) with F(0) = 0 and F(1) = 1.
# Given a number, say prod (for product), we search two Fibonacci numbers F(n) and F(n+1) verifying

# F(n) * F(n+1) = prod.
# Your function productFib takes an integer (prod) and returns an array:

# [F(n), F(n+1), true] or {F(n), F(n+1), 1} or (F(n), F(n+1), True)
# depending on the language if F(n) * F(n+1) = prod.

def productFib(prod)
  fib__lmt = get_limited_fib(prod/2.0)
  fib_divisors = get_fib_divisors(fib__lmt,get_all_divisors(prod))
  puts fib__lmt.to_s
  resp = [nil, nil, false]
  fib_divisors.each do |e|
    puts e
    nxt = fib__lmt[fib__lmt.index(e)+1]
    if e*nxt <= prod
      if e*nxt == prod
        resp[2] = true
        resp[0] = e
        resp[1] = nxt
        break
      end
    else
      break
    end
  end
  unless resp[2]
    idx = find_least_multipliers(fib__lmt, prod)
    resp = [fib__lmt[idx],fib__lmt[idx+1],false]
  end
  resp
end

def find_least_multipliers(fib__lmt, prod)
  idx = fib__lmt.length - 2
  while fib__lmt[idx]*fib__lmt[idx+1] > prod && idx>0
    idx -= 1
  end
  return idx+1
end


def get_all_divisors(number)
  div_candidate = (number/2.0).floor
  div_ary = []
  while(div_candidate > 1)
    mod = number%div_candidate
    div_ary.push div_candidate if mod == 0
    div_candidate -= 1
  end
  return div_ary.push 1
end

def get_limited_fib(number)
  ary = [0]
  ary.push 1 if number > 0
  while (ary[-1] <= number) && ary.length > 1
    if ary[-1]+ary[-2] <= number
      ary.push(ary[-1]+ary[-2])
    else
      break
    end
  end
  return ary
end

def get_fib_divisors(fib_ary, div_ary)
  return fib_ary.select{|e| div_ary.include?(e) }
end

#puts productFib(4895) == [55, 89, true]
#puts productFib(5895) == [89, 144, false]

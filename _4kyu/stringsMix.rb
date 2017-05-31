# Given two strings s1 and s2, we want to visualize how different the two strings are. We will only take into account the lowercase letters (a to z). First let us count the frequency of each lowercase letters in s1 and s2.

# s1 = "A aaaa bb c"

# s2 = "& aaa bbb c d"

# s1 has 4 'a', 2 'b', 1 'c'

# s2 has 3 'a', 3 'b', 1 'c', 1 'd'

# So the maximum for 'a' in s1 and s2 is 4 from s1; the maximum for 'b' is 3 from s2. In the following we will not consider letters when the maximum of their occurrences is less than or equal to 1.

# We can resume the differences between s1 and s2 in the following string: "1:aaaa/2:bbb" where 1 in 1:aaaa stands for string s1 and aaaa because the maximum for a is 4. In the same manner 2:bbb stands for string s2 and bbb because the maximum for b is 3.

# The task is to produce a string in which each lowercase letters of s1 or s2 appears as many times as its maximum if this maximum is strictly greater than 1; these letters will be prefixed by the number of the string where they appear with their maximum value and :. If the maximum is in s1 as well as in s2 the prefix is =:.

# In the result, substrings (a substring is for example 2:nnnnn or 1:hhh; it contains the prefix) will be in decreasing order of their length and when they have the same length sorted in ascending lexicographic order (letters and digits - more precisely sorted by codepoint); the different groups will be separated by '/'. See examples and "Example Tests".

# Hopefully other examples can make this clearer.

# s1 = "my&friend&Paul has heavy hats! &"
# s2 = "my friend John has many many friends &"
# mix(s1, s2) --> "2:nnnnn/1:aaaa/1:hhh/2:mmm/2:yyy/2:dd/2:ff/2:ii/2:rr/=:ee/=:ss"

# s1 = "mmmmm m nnnnn y&friend&Paul has heavy hats! &"
# s2 = "my frie n d Joh n has ma n y ma n y frie n ds n&"
# mix(s1, s2) --> "1:mmmmmm/=:nnnnnn/1:aaaa/1:hhh/2:yyy/2:dd/2:ff/2:ii/2:rr/=:ee/=:ss"

# s1="Are the kids at home? aaaaa fffff"
# s2="Yes they are here! aaaaa fffff"
# mix(s1, s2) --> "=:aaaaaa/2:eeeee/=:fffff/1:tt/2:rr/=:hh"
ABC = "abcdefghijklmnopqrstuvwxyz"

def get_amount_of_all_letters(str, hshy = {})
  # abc = get_abc_from_strs(str, "").join('')
  ABC.split('').each do |abc|
    cnt = str.count(abc)
    hshy[abc] = cnt > 1 ? cnt : nil
  end
  return hshy
end

def get_each_count_from_both(s1,s2, hshy={})
  # abc = get_abc_from_strs(s1, s2).join('')
  s1 = get_amount_of_all_letters s1
  s2 = get_amount_of_all_letters s2
  # puts s1, s2
  ABC.split('').each do |abc|
    if(!s1[abc].nil? && !s2[abc].nil?)
      if(s1[abc] > s2[abc])
        hshy[s1[abc].to_s+abc] = '1:'+abc*s1[abc]
      elsif((s1[abc] < s2[abc]))
        hshy[s2[abc].to_s+abc] = '2:'+abc*s2[abc]
      else
        hshy[s2[abc].to_s+abc] = "=:"+abc*s2[abc]
      end
    elsif(!s1[abc].nil? || !s2[abc].nil?)
      s1[abc].nil? ? hshy[s2[abc].to_s+abc] = '2:'+abc*s2[abc].to_i : hshy[s1[abc].to_s+abc] = '1:'+abc*s1[abc].to_i
    end
  end
  return hshy
end

def mix(s1, s2)
  tmp=[]
  tmp2=[]
  str=""
  aux = nil
  hsh = get_each_count_from_both s1, s2
  puts hsh = (hsh.sort_by{|k,v|k.split('')[0]}).reverse.to_h
  hsh.each do |k,v|
    if aux.nil?
      puts '...0'
      str = v
      aux = k.split('')[0]
      puts aux
      puts str
    elsif k.split('')[0] != aux
      puts '...1'
      tmp.push str
      str = v
      aux = k.split('')[0]
      puts str
      puts aux
      puts tmp
    else
      puts '...2'
      str = str+"-"+v
      puts str
    end
  end
  tmp.push str
  puts tmp.to_s
  tmp.each do |v|
    aux = v.split('-').sort { |x,y| x <=> y }
    tmp2.concat aux
  end
  tmp2.join('/')
end

# def get_abc_from_strs(s1,s2)
#   s1 = s1.split('').uniq
#   s2 = s2.split('').uniq
#   ss = s1.concat s2
#   return ss.uniq.reject{|x| x == ' '}
# end

# ABC = get_abc_from_strs("looping is fun but dangerous", "less dangerous than coding").join('')


# puts mix("Are thexxxxy here", "yes, theyxxxx are hereyyy") == "2:eeeee/2:yy/=:hh/=:rr"
puts mix("looping is fun but dangerous", "less dangerous than coding") == "1:ooo/1:uuu/2:sss/=:nnn/1:ii/2:aa/2:dd/2:ee/=:gg"
# puts mix(" In many languages", " there's a pair of functions") == "1:aaa/1:nnn/1:gg/2:ee/2:ff/2:ii/2:oo/2:rr/2:ss/2:tt"
# puts mix("Lords of the Fallen", "gamekult") == "1:ee/1:ll/1:oo"
# puts mix("codewars", "codewars") == ""
# puts mix("A generation must confront the looming ", "codewarrs") == "1:nnnnn/1:ooooo/1:tttt/1:eee/1:gg/1:ii/1:mm/=:rr"


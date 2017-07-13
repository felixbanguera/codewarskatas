#mix("Are they here", "yes, they are here") == "2:eeeee/2:yy/=:hh/=:rr"
#mix("looping is fun but dangerous", "less dangerous than coding") == "1:ooo/1:uuu/2:sss/=:nnn/1:ii/2:aa/2:dd/2:ee/=:gg"
#mix(" In many languages", " there's a pair of functions") == "1:aaa/1:nnn/1:gg/2:ee/2:ff/2:ii/2:oo/2:rr/2:ss/2:tt"
#mix("Lords of the Fallen", "gamekult") == "1:ee/1:ll/1:oo"
#mix("codewars", "codewars") == ""
#mix("A generation must confront the looming ", "codewarrs") == "1:nnnnn/1:ooooo/1:tttt/1:eee/1:gg/1:ii/1:mm/=:rr"
ABC = "abcdefghijklmnopqrstuvwxyz"

def get_amount_of_all_letters(str, hshy = {})
  ABC.split('').each do |abc|
    cnt = str.count(abc)
    hshy[abc] = cnt > 1 ? cnt : nil
  end
  return hshy
end

def get_each_count_from_both(s1,s2, hshy={})
  s1 = get_amount_of_all_letters s1
  s2 = get_amount_of_all_letters s2
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
  hsh = (hsh.sort_by{|k,v|k.split('')[0]}).reverse.to_h
  hsh.each do |k,v|
    if aux.nil?
      str = v
      aux = k.split('')[0]
    elsif k.split('')[0] != aux
      tmp.push str
      str = v
      aux = k.split('')[0]
    else
      str = str+"-"+v
    end
  end
  tmp.push str
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
# puts mix("looping is fun but dangerous", "less dangerous than coding") == "1:ooo/1:uuu/2:sss/=:nnn/1:ii/2:aa/2:dd/2:ee/=:gg"
# puts mix(" In many languages", " there's a pair of functions") == "1:aaa/1:nnn/1:gg/2:ee/2:ff/2:ii/2:oo/2:rr/2:ss/2:tt"
# puts mix("Lords of the Fallen", "gamekult") == "1:ee/1:ll/1:oo"
# puts mix("codewars", "codewars") == ""
puts mix("A generation must confront the looming ", "codewarrs") == "1:nnnnn/1:ooooo/1:tttt/1:eee/1:gg/1:ii/1:mm/=:rr"


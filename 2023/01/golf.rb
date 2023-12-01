def g(h, n);(h.index(n)%9+1).to_s;end
def s(ls, ps);ls.map{|l|(g(ps,l.match(ps.join("|"))[0])+g(ps,l.reverse.match(ps.map(&:reverse).join("|"))[0].reverse)).to_i}.sum;end
ls=ARGF.readlines()
puts s(ls, ('1'..'9').to_a)
puts s(ls, ('1'..'9').to_a+%w{one two three four five six seven eight nine})


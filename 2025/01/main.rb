#!/usr/bin/env ruby
x = $<.reduce([50]){_1<<_1[-1]+_2.tr('LR','-+').to_i}
p [x.count{it%100<1},x.each_cons(2).sum{|l,r|l.step(r,r<=>l).drop(1).count{it%100<1}}]


require './setting'
require './game'
require "optparse"

options = ARGV.getopts("", "log")

list = []

100.times do
  p "初期状態" if options["log"]
  ary = set_first_ary
  array_print(ary) if options["log"]
  list.push(do_game(ary, options["log"]).flatten.max)
end

p list
p "最大値：#{list.max}"
p "最小値：#{list.min}"
p "平均値：#{list.inject(0.0){|r,i| r+=i }/list.size}"
p "最頻値：#{list.max_by {|value| list.count(value)}}"

require './setting'
require './algorithm'
require 'optparse'
require 'benchmark'

options = ARGV.getopts("", "log")

list = []

game_number = 100

result = Benchmark.realtime do
  game_number.times do
    p "初期状態" if options["log"]
    ary = set_first_ary
    array_print(ary) if options["log"]
    list.push({max: do_game(ary, options["log"])[0].flatten.max, num: do_game(ary, options["log"])[1] })
  end
end

# list.each do |l|
#   p "max: #{l[:max]}   num: #{l[:num]}"
# end
# p "最大値：#{list.max}"
# p "最小値：#{list.min}"
# p "平均値：#{list.inject(0.0){|r,i| r+=i }/list.size}"
# p "最頻値：#{list.max_by {|value| list.count(value)}}"
p "ゲーム回数                   #{game_number}回"
p "各ゲーム最大値のの平均値     #{list.sum {|l| l[:max]}.to_f / list.size}"
p "各ゲームスワイプ回数の平均値 #{list.sum {|l| l[:num]}.to_f / list.size}"
p "処理時間                     #{result}s"

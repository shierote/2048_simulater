require './setting'
require './algorithm'
require 'optparse'
require 'benchmark'

options = ARGV.getopts("", "log")

list = []

game_number = 100
list_max = 0
list_max_num = 0

result = Benchmark.realtime do
  game_number.times do
    p "初期状態" if options["log"]
    ary = set_first_ary
    array_print(ary) if options["log"]
    max = do_game(ary, options["log"])[0].flatten.max
    num = do_game(ary, options["log"])[1]
    list.push({ max: max, num: num })
    if list_max < max
      list_max = max
      list_max_num = num
    end
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
p "全ゲームの最大値             #{list_max}"
p "全ゲームの最大値の時の回数   #{list_max_num}"
p "各ゲーム最大値のの平均値     #{list.inject(0) {|sum, hash| sum + hash[:max]}.to_f / list.size}"
p "各ゲームスワイプ回数の平均値 #{list.sum {|l| l[:num]}.to_f / list.size}"
p "処理時間                     #{result}s"

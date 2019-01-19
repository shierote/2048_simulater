require './setting'
require './algorithm'
require 'optparse'
require 'benchmark'
require 'csv'

options = ARGV.getopts("", "log", "csv", "alg:", "game_num:", "hist", "no_log")

list = []
max_list = []
game_max = 0
game_max_num = 0

############################
# ゲーム回数
game_number = 100
game_number = options["game_num"].to_i if options["game_num"]
# どのアルゴリズムを使うか
used_alg = "tlrb"
used_alg = options["alg"] if options["alg"]
############################

result = Benchmark.realtime do
  game_number.times do
    p "初期状態" if options["log"]
    ary = set_first_ary
    array_print(ary) if options["log"]
    game_result = do_game(ary, used_alg, options["log"])
    array_print(ary) if options["log"]
    max = game_result[0].flatten.max
    num = game_result[1]
    list.push({ max: max, num: num })
    max_list.push(max)
    if game_max < max
      game_max = max
      game_max_num = num
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

h = max_list.group_by(&:itself).map{|k, v| [k, v.size]}.to_h
h = Hash[ h.sort ]

if options["csv"]
  csv_name = "#{Time.now.strftime("%Y%m%d_%H%M%S")}_#{used_alg}_#{game_number}.csv"
  p "CSVファイル名                #{csv_name}"
  CSV.open("csv/#{csv_name}","w") do |test|
    test << ["ゲーム回数:#{game_number}回", "使用したアルゴリズム:#{used_alg}"]
    h.each do |key, val|
      test << [key, val]
    end
  end
end

if options["hist"]
  p "最大値のヒストグラム         #{h}"
  sum = 0
  h.each do |k, v|
    sum += k*v
  end
  p "総合点                       #{sum}"
end

unless options["no_log"]
  p "使用しているアルゴリズム     #{used_alg}"
  p "ゲーム回数                   #{game_number}回"
  p "全ゲームの最大値             #{game_max}"
  p "全ゲームの最大値の時の回数   #{game_max_num}"
  p "各ゲーム最大値のの平均値     #{list.inject(0) {|sum, hash| sum + hash[:max]}.to_f / list.size}"
  p "各ゲームスワイプ回数の平均値 #{list.inject(0) {|sum, hash| sum + hash[:num]}.to_f / list.size}"
  p "処理時間                     #{result}s"
end

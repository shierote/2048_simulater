require './game_setting'

def do_game(ary)
  mark = true
  while(mark) do
    ary = swape_alg(ary)
    if ary.flatten == to_top(ary).flatten && ary.flatten == to_left(ary).flatten \
        && ary.flatten == to_right(ary).flatten && ary.flatten == to_bottom(ary).flatten
      result = ary
      mark = false
      array_print(ary)
      p "===終了==="
    end
    ary = random_1(ary)
  end
  return result
end

def swape_alg(ary)
  if ary.flatten != to_top(ary).flatten
    # p "===top==="
    return to_top(ary)

  elsif ary.flatten != to_left(ary).flatten
    # p "===left==="
    return to_left(ary)

  elsif ary.flatten != to_right(ary).flatten
    # p "===right==="
    return to_right(ary)

  else ary.flatten != to_bottom(ary).flatten
    # p "===bottom==="
    return to_bottom(ary)
  end
end

first_ary = Array.new(4).map{Array.new(4,0)}

rand(8)
# 初期状態の設定、できればここもランダムにしたい
first_ary[1][1] = 4
first_ary[2][0] = 2
first_ary[2][2] = 2

p "初期状態"

array_print(first_ary)

list = []

10.times do
  list.push(do_game(first_ary).flatten.max)
end

p list
p "最大値：#{list.max}"
p "最小値：#{list.min}"
p "平均値：#{list.inject(0.0){|r,i| r+=i }/list.size}"
p "最頻値：#{list.max_by {|value| list.count(value)}}"

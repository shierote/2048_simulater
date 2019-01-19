# 各状態の出力(普通に出力すると非常に見づらいので)
def array_print(ary)
  ary.each{|a| p a }
end

# 左スワイプ
def to_left(ary)
  ary_tmp = Marshal.load(Marshal.dump(ary))
  return ary_tmp.select{|a| a = add(a)}
end

def to_right(ary)
  ary_tmp = Marshal.load(Marshal.dump(ary))
  return ary_tmp.select{|a| a = add(a.reverse!).reverse!}
end

def to_top(ary)
  ary_tmp = Marshal.load(Marshal.dump(ary))
  ary_tmp = ary_tmp.transpose
  return ary_tmp.select{|a| a = add(a)}.transpose
end

def to_bottom(ary)
  ary_tmp = Marshal.load(Marshal.dump(ary))
  ary_tmp = ary_tmp.transpose
  return ary_tmp.select{|a| a = add(a.reverse!).reverse!}.transpose
end

# スワイプ時の足し算
def add(ary)
  a = zero_transport(ary)
  if a[0] == a[1]
    a[0] += a[1]
    a[1] = 0
  end
  if a[1] == a[2]
    a[1] += a[2]
    a[2] = 0
  end
  if a[2] == a[3]
    a[2] += a[3]
    a[3] = 0
  end
  return zero_transport(a)
end

# 移動した隙間を0で埋める
def zero_transport(ary)
  reject_ary = ary.reject{|e| e == 0}
  reject_ary.each_with_index do |a, i|
    ary[i] = a
  end
  for i in reject_ary.length..3
    ary[i] = 0
  end
  return ary
end

# ランダムで2か4を一つ0のところに加える
def random_1(ary)
  return [] if zero_list(ary).length == 0
  change_list = zero_list(ary)[rand(0..zero_list(ary).length-1)]
  ary[change_list[0]][change_list[1]] = 2*rand(1..2)
  return ary
end

# 0の位置を表す配列を返す（ixj行列のイメージで）
def zero_list(ary)
  zero_list = []
  ary.each_with_index do |a, i|
    a.each_with_index do |b, j|
      zero_list.push([i,j]) if b == 0
    end
  end
  return zero_list
end

# これ以上動かせなければtrueを返す
def game_over?(ary)
  if ary.flatten == to_top(ary).flatten && ary.flatten == to_left(ary).flatten \
        && ary.flatten == to_right(ary).flatten && ary.flatten == to_bottom(ary).flatten
    return true
  end
  return false
end

def set_first_ary
  first_ary = Array.new(4).map{Array.new(4,0)}
  marker = true
  while(marker) do
   first_ary[rand(0..3)][rand(0..3)] = 2*rand(1..2)
   if zero_list(first_ary).length == 14
     marker = false
   end
  end
  return first_ary
end

def do_game(ary, alg ,log)
  num = 0
  mark = true
  while(mark) do
    ary_tmp = Marshal.load(Marshal.dump(ary))
    # この_algがswape方向を決めるアルゴリズム
    ary = tlrb_alg(ary, log) if alg == "tlrb"
    ary = ltrb_alg(ary, log) if alg == "ltrb"
    ary = rand_alg(ary, log) if alg == "rand"
    ary = debug_alg(ary, log) if alg == "debug"
    ary = tree_alg(ary, log) if alg == "tree"
    ary = ltrb_tree_alg(ary, log) if alg == "ltrb_tree"
    num += 1
    if ary != ary_tmp
      ary = random_1(ary)
    end
    array_print(ary) if log
    # p ary
    ary_test = Marshal.load(Marshal.dump(ary))
    if game_over?(ary_test)
      result = ary
      mark = false
      p "===終了===" if log
      array_print(ary) if log
    end
  end
  return [result, num]
end

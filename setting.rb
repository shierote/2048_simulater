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
  return ary if zero_list(ary).length == 0
  change_list = zero_list(ary)[rand(0..zero_list(ary).length-1)]
  ary_tmp = Marshal.load(Marshal.dump(ary))
  ary_tmp[change_list[0]][change_list[1]] = 2*rand(1..2)
  return ary_tmp
end

# 全ての位置に2or4を加える
def all_1(ary)
  ary_ary = []
  if zero_list(ary).length == 0
    ary_ary.push(ary)
    return ary_ary
  end
  i = 0
  ary_tmp = Marshal.load(Marshal.dump(ary))
  while i < zero_list(ary).length
    ary_tmp[zero_list(ary)[i][0]][zero_list(ary)[i][1]]= 2
    ary_ary.push(ary_tmp)
    ary_tmp[zero_list(ary)[i][0]][zero_list(ary)[i][1]]= 4
    ary_ary.push(ary_tmp)
    ary_tmp[zero_list(ary)[i][0]][zero_list(ary)[i][1]]= 0
    i += 1
  end
  return ary_ary
end

# 0の位置を表す配列を返す（i行j列のイメージで）
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
  if ary == to_top(ary) && ary == to_left(ary) \
        && ary == to_right(ary) && ary == to_bottom(ary)
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
    # この_algがswape方向を決めるアルゴリズム
    ary_tmp = Marshal.load(Marshal.dump(ary))
    case alg
    when "tlrb"
      ary = tlrb_alg(ary, log)
    when "ltrb"
      ary = ltrb_alg(ary, log)
    when "rand"
      ary = rand_alg(ary, log)
    when "debug"
      ary = debug_alg(ary, log)
    when "tree"
      ary = tree_alg(ary, log)
    when "tree3"
      ary = tree3_score_alg(ary, log)
    when "tree3-2"
      ary = tree3_score_alg_2(ary,log)
    else
      ary = debug_alg(ary, log)
    end
    num += 1
    # ドーピング
    if ary != ary_tmp
      ary = random_1(ary)
    end
    array_print(ary) if log
    ary_test = Marshal.load(Marshal.dump(ary))
    if game_over?(ary_test)
      result = ary
      mark = false
      p "===game over===" if log
    end
  end
  return [result, num]
end

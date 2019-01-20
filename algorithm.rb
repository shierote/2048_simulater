require './setting'

# 上左右下アルゴリズム
def tlrb_alg(ary, log)
  if ary != to_top(ary)
    p "===top===" if log
    return to_top(ary)

  elsif ary != to_left(ary)
    p "===left===" if log
    return to_left(ary)

  elsif ary != to_right(ary)
    p "===right===" if log
    return to_right(ary)

  else ary != to_bottom(ary)
    p "===bottom===" if log
    return to_bottom(ary)
  end
end

# 完全にランダム
def rand_alg(ary, log)
  ram = rand(0..3)
  if ram == 0
    p "===top===" if log
    return to_top(ary)

  elsif ram == 1
    p "===left===" if log
    return to_left(ary)

  elsif ram == 2 
    p "===right===" if log
    return to_right(ary)

  else
    p "===bottom===" if log
    return to_bottom(ary)
  end
end

# デバッグ用アルゴリズム
def debug_alg(ary, log)
  p '方向を入力してください。h:← j:↓ k:↑ l:→'
  input = gets
  input.chomp!
  case input
  when "k"
    p "===top===" if log
    return to_top(ary)

  when "h"
    p "===left===" if log
    return to_left(ary)

  when "l"
    p "===right===" if log
    return to_right(ary)

  when "j"
    p "===bottom===" if log
    return to_bottom(ary)
  else
    debug_alg(ary, log)
  end
end

# Minimaxアルゴリズム
def minimax_alg(ary, log)
  #if ary.flatten != to_top(ary).flatten
  #  p "===top===" if log
  #  return to_top(ary)

  #elsif ary.flatten != to_left(ary).flatten
  #  p "===left===" if log
  #  return to_left(ary)

  #elsif ary.flatten != to_right(ary).flatten
  #  p "===right===" if log
  #  return to_right(ary)

  #else ary.flatten != to_bottom(ary).flatten
  #  p "===bottom===" if log
  #  return to_bottom(ary)
  #end
end

# 左上右下アルゴリズム
def ltrb_alg(ary, log)
  if ary != to_left(ary)
    p "===left===" if log
    return to_left(ary)

  elsif ary != to_top(ary)
    p "===top===" if log
    return to_top(ary)

  elsif ary != to_right(ary)
    p "===right===" if log
    return to_right(ary)

  else ary != to_bottom(ary)
    p "===bottom===" if log
    return to_bottom(ary)
  end
end

# ゲーム木アルゴリズム（1手先まで読む）
def tree_alg(ary, log)
  tree_list = []
  left = to_left(ary)
  tree_list.push([0, tree_alg_score(left)]) if ary != left
  right = to_right(ary)
  tree_list.push([1, tree_alg_score(right)]) if ary != right
  top = to_top(ary)
  tree_list.push([2, tree_alg_score(top)]) if ary != top
  bottom = to_bottom(ary)
  tree_list.push([3, tree_alg_score(bottom)]) if ary != bottom
  tree_list.sort_by {|x| x[1]}
  max = tree_list[0][0]
  p max if log
  case max
  when 0
    return to_left(ary)
  when 1
    return to_right(ary)
  when 2
    return to_top(ary)
  else
    return to_bottom(ary)
  end
end

def tree_alg_score(ary)
  zero_list(ary).size
end

def ltrb_tree_alg_3(ary, log)
  tree_list = []
  4.times do |i|
    4.times do |j|
      4.times do |k|
        sw_ary = random_1(swape_ary(random_1(swape_ary(random_1(swape_ary(ary, i)), j)), k))
        tree_list.push([i, j, k, ltrb_tree_score(sw_ary)])
      end
    end
  end
  tree_list.sort_by! {|x| x[3]}.reverse!
  p tree_list[0] if log
  a = swape_ary(ary, tree_list[0][0])
  if ary == a
    tree_list.each do |l|
      a = swape_ary(ary, l[0])
      return a if ary != a
    end
  end
  p a if log
  return a
end


def ltrb_tree_alg(ary, log)
  tree_list = []
  4.times do |i|
    4.times do |j|
      sw_ary = random_1(swape_ary(random_1(swape_ary(ary, i)), j))
      tree_list.push([i, j, ltrb_tree_score(sw_ary)])
    end
  end
  tree_list.sort_by! {|x| x[2]}.reverse!
  p tree_list[0] if log
  a = swape_ary(random_1(swape_ary(ary, tree_list[0][0])), tree_list[0][1])
  if ary == a
    tree_list.each do |l|
      a = swape_ary(random_1(swape_ary(ary, l[0])), l[1])
      return a if ary != a
    end
  end
  p a if log
  return a
end

def ltrb_tree_alg_2(ary, log)
  tree_list = []
  4.times do |i|
    4.times do |j|
      sw_ary = random_1(swape_ary(random_1(swape_ary(ary, i)), j))
      tree_list.push([i, j, ltrb_tree_score(sw_ary)])
    end
  end
  tree_list.sort_by! {|x| x[2]}.reverse!
  p tree_list[0] if log
  a = swape_ary(ary, tree_list[0][0])
  if ary == a
    tree_list.each do |l|
      a = swape_ary(ary, l[0])
      return a if ary != a
    end
  end
  p a if log
  return a
end

def swape_ary(ary, n) 
  left = to_left(ary)
  right = to_right(ary)
  top = to_top(ary)
  bottom = to_bottom(ary)
  # require'pry';binding.pry
  if n == 0
    return left
  elsif n == 1
    return top
  elsif n == 2
    return right
  else
    return bottom
  end
end


def ltrb_tree_score(ary)
  score_list = [[8192,  4096, 2048,  1048],
                [  64,   128,  256,   512],
                [  32,    16,    8,     4],
                [   0,     0,    0,     2]]
  # array_print(score_list) 
  # score_list = [[1024,  256, 128,  64],
  #       [   4,    8,  16,  32],
  #       [   0,    0,   0,   0],
  #       [   0,    0,   0,   0]]
  # score_list = [[2048+(2048/(ary[0][0]+1)),  1024+(1024/(ary[0][1]+1)), 512+(1024/(ary[0][2]+1)),  256+(1024/(ary[0][3]+1))],
  #       [  16,   32,   64,   128],
  #       [   8,    4,   2,   1],
  #       [   1,    0,   0,   0]]
  s = 0
  4.times do |i|
    4.times do |j|
      s += ary[i][j]*score_list[i][j]
    end
  end
  return s
  # return  ary[0][0]*64 \
  #       + ary[0][1]*16 + ary[1][0]*16 \
  #       + ary[0][2]*4 + ary[1][1]*4 + ary[2][0]*4 \
  #       + ary[0][3]*2 + ary[1][2]*2 + ary[2][1]*2 + ary[3][0]*2 \
  #                     + ary[1][3]*1 + ary[2][2]*1 + ary[3][1]*1
end

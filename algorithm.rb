require './setting'

# 上左右下アルゴリズム
def tlrb_alg(ary, log)
  if ary.flatten != to_top(ary).flatten
    p "===top===" if log
    return to_top(ary)

  elsif ary.flatten != to_left(ary).flatten
    p "===left===" if log
    return to_left(ary)

  elsif ary.flatten != to_right(ary).flatten
    p "===right===" if log
    return to_right(ary)

  else ary.flatten != to_bottom(ary).flatten
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
def debug_alg(ary)
  p '方向を入力してください。h:← j:↓ k:↑ l:→'
  input = gets
  input.chomp!
  case input
  when "k" then
    # p "===top==="
    return to_top(ary)

  when "h" then
    # p "===left==="
    return to_left(ary)

  when "l" then
    # p "===right==="
    return to_right(ary)

  when "j" then
    # p "===bottom==="
    return to_bottom(ary)
  end
end

# Minimaxアルゴリズム
def minimax_alg(ary, log)
  if ary.flatten != to_top(ary).flatten
    p "===top===" if log
    return to_top(ary)

  elsif ary.flatten != to_left(ary).flatten
    p "===left===" if log
    return to_left(ary)

  elsif ary.flatten != to_right(ary).flatten
    p "===right===" if log
    return to_right(ary)

  else ary.flatten != to_bottom(ary).flatten
    p "===bottom===" if log
    return to_bottom(ary)
  end
end

# 左上右下アルゴリズム
def ltrb_alg(ary, log)
  if ary.flatten != to_left(ary).flatten
    p "===left===" if log
    return to_left(ary)

  elsif ary.flatten != to_top(ary).flatten
    p "===top===" if log
    return to_top(ary)

  elsif ary.flatten != to_right(ary).flatten
    p "===right===" if log
    return to_right(ary)

  else ary.flatten != to_bottom(ary).flatten
    p "===bottom===" if log
    return to_bottom(ary)
  end
end

# ゲーム木アルゴリズム（1手先まで読む）
def tree_alg(ary, log)
  tree_list = []
  ary_test = Marshal.load(Marshal.dump(ary))
  left = to_left(ary)
  tree_list.push([0, tree_alg_score(left)]) if ary_test != left
  right = to_right(ary)
  tree_list.push([1, tree_alg_score(right)]) if ary_test != right
  top = to_top(ary)
  tree_list.push([2, tree_alg_score(top)]) if ary_test != top
  bottom = to_bottom(ary)
  tree_list.push([3, tree_alg_score(bottom)]) if ary_test != bottom
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

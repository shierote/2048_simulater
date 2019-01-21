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
        if i == 3 || j == 3 || k == 3
          tree_list.push([i, j, k, ltrb_tree_score(sw_ary)/((i+1)*(j+1)*(k+1))])
        else
          tree_list.push([i, j, k, ltrb_tree_score(sw_ary)])
        end
      end
    end
  end
  tree_list.sort_by! {|x| x[3]}.reverse!
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

def tree_alg_4(ary, log)
  tree_list = []
  # zero_count = zero_list(ary).size
  # if zero_count < 1
  #   4.times do |i|
  #     4.times do |j|
  #       sw_ary = random_1(swape_ary(random_1(swape_ary(ary, i)), j))
  #       tree_list.push([i, j, ltrb_tree_score(sw_ary)*zero_count])
  #     end
  #   end
  #   tree_list.sort_by! {|x| x[2]}.reverse!
  #   a = swape_ary(ary, tree_list[0][0])
  #   if ary == a
  #     tree_list.each do |l|
  #       a = swape_ary(ary, l[0])
  #       return a if ary != a
  #     end
  #   end
  #   return a
  # end
  4.times do |i|
    4.times do |j|
      4.times do |k|
      #   4.times do |m|
          # sw_ary = random_1(swape_ary(random_1(swape_ary(random_1(swape_ary(random_1(swape_ary(ary, i)), j)), k)), m))
          sw_ary = swape_ary(random_1(swape_ary(ary, i)), j)
          sw_ary = swape_ary(random_1(swape_ary(random_1(swape_ary(ary, i)), j)), k)
          lt_score  = ltrb_tree_score(sw_ary)
          lt_score /= 30  if sw_ary.flatten.max != sw_ary[0][0]
          # lt_score /= (i+1)*(j+1)*(k+1)*(m+1) if i == 3 || j == 3 || k == 3 || m == 3
          lt_score /= (i+1)*(j+1)*(k+1) if i == 3 || j == 3 || k == 3
          lt_score /= 10 if sw_ary[0].include?(0) && (i == 2)

          # tree_list.push([i, j, k, m, lt_score])
          # tree_list.push([i, j, lt_score])
          tree_list.push([i, j, k, lt_score])
      #   end
      end
    end
  end
  # tree_list.sort_by! {|x| x[4]}.reverse!
  tree_list.sort_by! {|x| x[3]}.reverse!
  a = swape_ary(ary, tree_list[0][0])
  if ary == a
    tree_list.each do |l|
      a = swape_ary(ary, l[0])
      return a if ary != a
    end
  end
  p "=========" if log
  return a
end

def ltrb_tree_alg_5(ary, log)
  tree_list = []
  4.times do |i|
    4.times do |j|
      4.times do |k|
        #  if ary.flatten.count(0) > 4 || ary.flatten.max < 2048
           sw_ary1 = random_1(swape_ary(ary, i))
           sw_ary2 = random_1(swape_ary(sw_ary1, j))
           sw_ary = random_1(swape_ary(sw_ary2, k))

           score = ltrb_tree_score(sw_ary)
           #score *= 5 if i == 0
           #score *= 5 if j == 0
           #score *= 5 if k == 0
           score = 0 if i == 3
           score = 0 if j == 3
           score = 0 if k == 3
           #score = 0 if ary[0][2] == 0 && i == 2
           #score = 0 if ary[0][3] == 0 && i == 2
           if ary.flatten.max > 256
             score = 0 if sw_ary1.flatten.max != sw_ary1[0][0]
             score = 0 if sw_ary2.flatten.max != sw_ary2[0][0]
             score = 0 if sw_ary.flatten.max != sw_ary[0][0]
           end
           score /= 15 if sw_ary1[0].include?(0) && i == 2
           score /= 10 if sw_ary2[0].include?(0) && j == 2
           score /= 5 if sw_ary[0].include?(0) && k == 2
           #score /= 5 if sw_ary[0].min < sw_ary[1].max
           score = 0 if game_over?(sw_ary1) #OK
           score = 0 if game_over?(sw_ary2) #OK
           score = 0 if game_over?(sw_ary) #OK
           tree_list.push([i, j, k, score, sw_ary])
        #  else
        #   score = ary[0].inject(:+)
        #   score *= ary[1].inject(:+)
        #   tree_list.push([i, j, k, score])
        # end
      end
    end
  end
  tree_list.sort_by! {|x| x[3]}.reverse!
  p "========" if log
  a = swape_ary(ary, tree_list[0][0])
  if ary == a
    tree_list.each do |l|
      a = swape_ary(ary, l[0])
      if ary != a 
        csv_log(ary, l[0])
        csv_log(a, "↑スワイプ後(#{tree_list.index(l)+1}位を採用)")
        return a 
      end
    end
  end
  csv_log(ary, tree_list[0][0])
  csv_log(a, "↑スワイプ後")
  return tree_list[0][4]
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
  score_list = [[16384, 4096, 1024, 256],
                [    0,    4,   16,  64],
                [    0,    0,    0,  16],
                [    0,    0,    0,   0]]
  s = 0
  4.times do |i|
    4.times do |j|
      s += ary[i][j]*score_list[i][j]
    end
  end
  return s
end

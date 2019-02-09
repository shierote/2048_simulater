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

# 今回のレポートで一番パフォーマンスが出るやつ（三手先まで読む）
def tree3_score_alg(ary, log)
  tree_list = []
  4.times do |i|
    4.times do |j|
      4.times do |k|
        sw_ary1 = random_1(swape_ary(ary, i))
           sw_ary2 = random_1(swape_ary(sw_ary1, j))
           sw_ary = random_1(swape_ary(sw_ary2, k))

           score = tree_score(sw_ary)
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

           tree_list.push([i, j, k, score])
         # else
         #  score = ary[0].inject(:+)
         #  score *= ary[1].inject(:+)
         #  tree_list.push([i, j, k, score])
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
        return a
      end
    end
  end
  # ドーピング
  # return tree_list[0][4]
  return a
end

#色々改良した
def tree3_score_alg_2(ary, log)
  tree_list = [[0,0],[1,0],[2,0],[3,0]]
  #if danger?(ary)
  #  es = escape(ary)
  #  tree_list_push()
  4.times do |i|
    4.times do |j|
      4.times do |k|

         5.times do

           sw_ary1 = random_1(swape_ary(ary, i))
           sw_ary2 = random_1(swape_ary(sw_ary1, j))
           sw_ary = random_1(swape_ary(sw_ary2, k))

           score = tree_score(sw_ary)
           #score *= 5 if i == 0
           #score *= 5 if j == 0
           #score *= 5 if k == 0
           score = 0 if i == 3
           score = 0 if j == 3
           score = 0 if k == 3
            score = 0 if sw_ary1.flatten.max != sw_ary1[0][0]
             score = 0 if sw_ary2.flatten.max != sw_ary2[0][0]
             score = 0 if sw_ary.flatten.max != sw_ary[0][0]
             #score /= 12 if sw_ary[0].min < sw_ary[1].max
             #score /= 6 if sw_ary[1].min < sw_ary[2].max
             #score /= 3 if sw_ary[2].min < sw_ary[3].max


           #score = 0 if game_over?(sw_ary1) #OK
           #score /= 10 if game_over?(sw_ary2) #OK
           #score /= 5  if game_over?(sw_ary) #OK

           sw_ary3 = all_1(swape_ary(ary,i))
           sw_ary3.each do |sep_ary|
             if game_over?(sep_ary)
              score = 0
              break
             end
             if to_left(ary) == ary && to_right(ary) == ary && to_top(ary) == ary
               score = 0
             end
             #if ary.flatten.max != sep_ary[0][0] && ary.flatten.max > 128
            #   score = 0
            #   break
            # end
          end
          #escapeの時だけかな
          #score /= ary[2].max+1
          #score /= 2*(ary[3].max+1)


           if score >= tree_list[i][1]
             tree_list[i][1] = score
           end
         # else
         #  score = ary[0].inject(:+)
         #  score *= ary[1].inject(:+)
         #  tree_list.push([i, j, k, score])
          #end
          #break if tree_list[i][1] != 0
       end
      end
    end
  end
  tree_list.sort_by! {|x| x[1]}.reverse!
  p "========" if log
  tree_list.each do |l|
    a = swape_ary(ary, l[0])
    if ary != a
      #puts ary
      return a
    end
  end
  # ドーピング
  # return tree_list[0][4]
end
#escapeしたい、三列or二列重なる場合、二列目以降に大きい数きてしまった場合、小さい数が一列目に入った場合、順番ずれた場合

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

def tree_score(ary)
  score_list = [[2048, 256, 64, 16],
                [    0,    1,   2,  4],
                [    0,    0,    0,  2],
                [    0,    0,    0,   0]]
  s = 0
  4.times do |i|
    4.times do |j|
      s += ary[i][j]*score_list[i][j]
    end
  end
  return s
end

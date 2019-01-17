require './setting'

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

def do_game(ary, log)
  mark = true
  while(mark) do
    ary_tmp = Marshal.load(Marshal.dump(ary))
    # このswape_algがswape方向を決めるアルゴリズム
    ary = swape_alg(ary, log)
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
  return result
end

def swape_alg(ary, log)
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

def swape_alg2(ary)
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



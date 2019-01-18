require './setting'

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

# Minimaxアルゴリズム
def swape_alg_minimax(ary, log)
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

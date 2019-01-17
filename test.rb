require './setting'
require './algorithm'

test_ary = 
  [[2, 4, 2, 0], [4, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]]
p ""
array_print(test_ary)
p ""
array_print(to_top(test_ary))
array_print(swape_alg2(test_ary))

import unittest

import pykot/jrandom


# ##########
suite "random":
# ##########
  test "shuffled":
    let
      nums = @[1, 2, 3, 4]
      res = shuffled(nums)
    check (res.len == nums.len) and (nums == @[1, 2, 3, 4])

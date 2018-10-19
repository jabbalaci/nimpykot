import unittest

import pykot/types

# ############
suite "types":
# ############
  test "negative":
    let x: Negative = -1
    check x + 1 == 0

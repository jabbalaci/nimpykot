import unittest

import pykot/system


# ##########
suite "sys":
# ##########
  test "sys.argv":
    check len(sys.argv) > 0

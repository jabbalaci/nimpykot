import unittest

import pykot/jsystem


# ##########
suite "sys":
# ##########
  test "sys.argv":
    check len(sys.argv) > 0

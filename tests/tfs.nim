import unittest

import pykot/fs


# ##############
suite "fs":
# ##############
  test "which":
    when defined(linux):
      check which("date").len > 0
      check which("date_XXX").len == 0

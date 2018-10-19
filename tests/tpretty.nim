import unittest

import pykot/pretty


# ############
suite "pretty":
# ############
  test "prettyNum":
    check prettyNum(0) == "0"
    check prettyNum(100) == "100"
    check prettyNum(1_234) == "1,234"
    check prettyNum(1_234_567) == "1,234,567"
  
    check prettyNum(1_234_567, sep='_') == "1_234_567"

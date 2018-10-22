import unittest

import pykot/euler


# ##############
suite "euler":
# ##############
  test "is_prime":
    check 1.is_prime == false
    check 2.is_prime == true
    check 3.is_prime == true
    check 4.is_prime == false
    check 5.is_prime == true
    check 97.is_prime == true
    check 100.is_prime == false

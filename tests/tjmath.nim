import unittest

import pykot/jmath

# ##############
suite "jmath":
# ##############
  test "is_prime":
    check 1.is_prime == false
    check 2.is_prime == true
    check 3.is_prime == true
    check 4.is_prime == false
    check 5.is_prime == true
    check 97.is_prime == true
    check 100.is_prime == false

  test "to_digits":
    check 123.to_digits == @[3, 2, 1]
    check 2025.to_digits == @[5, 2, 0, 2]
    check 0.to_digits == @[0]
    check 1.to_digits == @[1]
    check -0.to_digits == @[0]
    check -1.to_digits == @[1]
    check -42.to_digits == @[2, 4]
    check -1977.to_digits == @[7, 7, 9, 1]

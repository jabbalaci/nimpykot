## Math-related things, e.g. check if a number is prime.

import math


func is_prime*(n: Positive): bool =
  ## Decide whether a number is prime or not.
  ##
  ## This is not an efficient implementation.
  runnableExamples:
    doAssert 1.is_prime == false
    doAssert 2.is_prime == true
    doAssert 3.is_prime == true
    doAssert 4.is_prime == false
    doAssert 5.is_prime == true
    doAssert 97.is_prime == true
    doAssert 100.is_prime == false

  if n < 2:
      return false
  if n == 2:
      return true
  if n mod 2 == 0:
      return false

  var i = 3
  let maxi = math.sqrt(float n) + 1
  while float(i) <= maxi:
      if n mod i == 0:
          return false
      i += 2

  true


func to_digits*(n: int): seq[int] =
  ## Get the digits of a number.
  ##
  ## For negative numbers, we work with the absolute value.
  ## The digits are returned in a reverse order.
  runnableExamples:
    doAssert 123.to_digits == @[3, 2, 1]
    doAssert 2025.to_digits == @[5, 2, 0, 2]
    doAssert 0.to_digits == @[0]
    doAssert -42.to_digits == @[2, 4]

  if n == 0:    # special case
    return @[0]

  var n = n.abs
  while n != 0:
    result &= n mod 10
    n = n div 10

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

  if n == 1:
      return false
  if n == 2:
      return true
  if n mod 2 == 0:
      return false

  var i = 3
  let maxi = math.sqrt(n.toFloat) + 1
  while i.toFloat <= maxi:
      if n mod i == 0:
          return false
      i += 2

  true

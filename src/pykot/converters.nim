import strutils


# #######
# Funcs #
# #######

func toInt*(n: int): int =
  ## Convert an int to int.
  ##
  ## It seems useless, but if you don't know the exact type of a variable
  ## in a chain and it happens to be an int, it does no harm.
  runnableExamples:
    doAssert 2.toInt == 2
    doAssert 123.toInt == 123

  n

func toInt*(s: string): int =
  ## Convert a string to int.
  runnableExamples:
    doAssert "42".toInt == 42
    doAssert "-576".toInt == -576

  parseInt(s)


func toInt*(digit: char): int =
  ## Convert a digit, represented as a char, to int.
  runnableExamples:
    doAssert '0'.toInt == 0
    doAssert '5'.toInt == 5

  parseInt($digit)

#
func toIntPart*(f: float): int =
  ## Convert a float to int and keep just the integer part.
  ##
  ## Keep just the integer part, do no rounding. Python's int(...) works like this.
  ## However, `system.toInt(f: float): int` does rounding.
  runnableExamples:
    doAssert (3.2).toIntPart == 3
    doAssert (3.8).toIntPart == 3
    doAssert (-3.2).toIntPart == -3
    doAssert (-3.8).toIntPart == -3
  
  int(f)

func toFloat*(f: float): float =
  ## Convert a float to float.
  ##
  ## It seems useless, but if you don't know the exact type of a variable
  ## in a chain and it happens to be a float, it does no harm.
  runnableExamples:
    doAssert (3.14).toFloat == 3.14

  f

func toFloat*(s: string): float =
  ## Convert a string to float.
  runnableExamples:
    doAssert "3.2".toFloat == 3.2

  parseFloat(s)

func toFloat*(c: char): float =
  ## Convert a digit, represented as a char, to float.
  runnableExamples:
    doAssert '0'.toFloat == 0.0
    doAssert '5'.toFloat == 5.0

  parseFloat($c)

# `system.toFloat(i: int): float` does exist


# ###########
# Templates #
# ###########

template str*(a: untyped): string =
  ## Convert something to string.
  runnableExamples:
    doAssert str(42) == "42"
    doAssert str(3.14) == "3.14"

  $a

template toStr*(a: untyped): string =
  ## Convert something to string.
  runnableExamples:
    doAssert 42.toStr == "42"
    doAssert (3.14).toStr() == "3.14"

  $a

import strutils
import sequtils
import unicode

# #######
# Procs #
# #######

# proc print*(x: varargs[typed, `$`]) {.magic: "Echo", tags: [WriteIOEffect], gcsafe, locks: 0, sideEffect.}

proc input*(prompt: string = ""): string =
  ## Python's `input()` function, i.e. read a line from the stdin.
  ## You can also specify a prompt.
  ##
  ## .. code-block:: nim
  ##
  ##     let name = input("Your name: ")

  stdout.write(prompt)
  stdin.readLine()

# #######
# Funcs #
# #######

func last*[T](a: seq[T]): T =
  ## Last element of a sequence.
  runnableExamples:
    let numbers = @[2, 7, 4, 9]
    doAssert numbers.last == 9

  a[^1]

func lastAscii*(s: string): char =
  ## Return the last character of a string.
  ## The returned value is a char (byte).
  ##
  ## If the last character is a non-ASCII character,
  ## use the function `lastRune`.
  runnableExamples:
    let name = "Nim"
    doAssert name.lastAscii == 'm'

  s[^1]

func lastRune*(s: string): Rune =
  ## Return the last Unicode character of a string.
  ## The returned value is a Rune.
  ##
  ## If the last character is an ASCII character,
  ## use the function `lastAscii`.
  runnableExamples:
    import unicode
    let name = "Alizé"
    doAssert $(name.lastRune) == "é"

  toSeq(s.runes)[^1]

func prettyNum*(n: int, sep=','): string =
  ## Prettify a number by adding separators at
  ## the positions of thousands.
  ##
  ## With the optional parameter `sep`, you can set the separator character.
  runnableExamples:
    doAssert prettyNum(2018) == "2,018"
    doAssert prettyNum(1_234_567) == "1,234,567"

  insertSep($n, sep=sep)

# ###########
# Iterators #
# ###########

iterator indices*[T](a: seq[T]): int =
  ## An iterator over the indices of a sequence.
  ##
  ## .. code-block:: nim
  ##
  ##    import
  ##      sequtils
  ##
  ##    let
  ##      numbers = @[2, 5, 8, 4]
  ##      res = toSeq(numbers.indices)
  ##    doAssert res == @[0, 1, 2, 3]

  for i in 0 .. a.high:
    yield i

iterator indicesAscii*(s: string): int =
  ## An iterator over the indices of an ASCII string.
  runnableExamples:
    import sequtils
    let
      lang = "Nim"
      res = toSeq(lang.indicesAscii)
    doAssert res == @[0, 1, 2]

  for i in 0 .. s.high:
    yield i

iterator until*(a, b: int): int =
  ## An iterator that goes from `a` (incl.) until `b` (excl.).
  ##
  ## I first saw this construction in Kotlin.
  runnableExamples:
    var
      res = newSeq[int]()
    for _ in 1.until(5):
      res.add(0)
    doAssert res == @[0, 0, 0, 0]

  var curr = a
  while curr < b:
    yield curr
    inc curr

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

template toInt*(n: int): int =
  ## Convert an int to int.
  ##
  ## It seems useless, but if you don't know the exact type of a variable
  ## in a chain and it happens to be an int, it does no harm.
  runnableExamples:
    doAssert 2.toInt == 2
    doAssert 123.toInt == 123

  n

template toInt*(s: string): int =
  ## Convert a string to int.
  runnableExamples:
    doAssert "42".toInt == 42
    doAssert "-576".toInt == -576

  parseInt(s)


template toInt*(digit: char): int =
  ## Convert a digit, represented as a char, to int.
  runnableExamples:
    doAssert '0'.toInt == 0
    doAssert '5'.toInt == 5

  parseInt($digit)

#
template toIntPart*(f: float): int =
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

template toFloat*(f: float): float =
  ## Convert a float to float.
  ##
  ## It seems useless, but if you don't know the exact type of a variable
  ## in a chain and it happens to be a float, it does no harm.
  runnableExamples:
    doAssert (3.14).toFloat == 3.14

  f

template toFloat*(s: string): float =
  ## Convert a string to float.
  runnableExamples:
    doAssert "3.2".toFloat == 3.2

  parseFloat(s)

template toFloat*(c: char): float =
  ## Convert a digit, represented as a char, to float.
  runnableExamples:
    doAssert '0'.toFloat == 0.0
    doAssert '5'.toFloat == 5.0

  parseFloat($c)

# `system.toFloat(i: int): float` does exist

template lastIndex*[T](a: seq[T]): int =
  ## Return the index of the last element of a sequence.
  runnableExamples:
    let
      a = @[4, 8, 3, 9]
    doAssert a.lastIndex == 3

  high(a)

template lastIndexAscii*(s: string): int =
  ## Return the index of the last character of a string.
  ##
  ## It works correctly only with an ASCII string.
  runnableExamples:
    let
      s = "Alice"
    doAssert s.lastIndexAscii == 4

  high(s)

template repeat*(times: static[Natural], body: untyped): untyped =
  ## Repeat a body N times.
  ##
  ## I saw it first in Kotlin.
  runnableExamples:
    var cnt = 0
    repeat(5):
      inc cnt
    doAssert cnt == 5

  for _ in 0 ..< times:
    body

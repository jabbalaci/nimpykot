import unittest
import sequtils
import unicode

import pykot


test "str":
  check str(23) == "23"
  check str(-3) == "-3"
  check str(0) == "0"
  check str("hello") == "hello"
  check str(3.14) == "3.14"

test "toStr":
  check toStr(23) == "23"
  check toStr(-3) == "-3"
  check toStr(0) == "0"
  check toStr("hello") == "hello"
  check toStr(3.14) == "3.14"
  
test "toInt / toIntPart":
  check toInt(0) == 0
  check toInt(-2) == -2
  check toInt(20) == 20
  check toInt("23") == 23
  check toInt('9') == 9

  # system.toInt() does rounding
  check toInt(3.14) == 3
  check toInt(-3.14) == -3
  check toInt(3.99) == 4
  check toInt(-3.99) == -4

  # keep just the integer part, i.e. no rounding
  check toIntPart(3.14) == 3
  check toIntPart(-3.14) == -3
  check toIntPart(3.99) == 3
  check toIntPart(-3.99) == -3

test "toFloat":
  check toFLoat(0) == 0.0
  check toFLoat(2) == 2.0
  check toFLoat(-2) == -2.0
  check toFLoat(3.14) == 3.14
  check toFLoat(-3.14) == -3.14
  check toFLoat("42") == 42.0
  check toFLoat("-42") == -42.0
  check toFLoat("42.5") == 42.5
  check toFLoat("-42.5") == -42.5
  check toFLoat('9') == 9.0

test "indices with sequences":
  let empty = newSeq[int]()
  check toSeq(indices(empty)) == empty
  check toSeq(indices(@[9])) == @[0]
  check toSeq(indices(@[3, 4, 5])) == @[0, 1, 2]

test "indices with strings":
  let empty = newSeq[int]()
  check toSeq("".indices()) == empty
  check toSeq("nim".indices()) == @[0, 1, 2]

test "lastIndex with sequences":
  let empty = newSeq[int]()
  check empty.lastIndex == -1
  check @[9].lastIndex == 0
  check @[1, 6, 4, 8].lastIndex == 3

test "lastIndex with ASCII strings":
  check "".lastIndexAscii == -1
  check "x".lastIndexAscii == 0
  check "nim".lastIndexAscii == 2

test "prettyNum":
  check prettyNum(0) == "0"
  check prettyNum(100) == "100"
  check prettyNum(1_234) == "1,234"
  check prettyNum(1_234_567) == "1,234,567"

  check prettyNum(1_234_567, sep='_') == "1_234_567"

test "repeat":
  var counter: int

  counter = 0
  repeat(5):
    inc counter
  check counter == 5
  #
  counter = 0
  repeat(0):
    inc counter
  check counter == 0
  #
  counter = 0
  repeat(-3):
    inc counter
  check counter == 0

test "until":
  var counter: int

  counter = 0
  for i in 1.until(5):
    inc counter
  check counter == 4
  #
  counter = 0
  for i in 1.until(1):
    inc counter
  check counter == 0
  #
  counter = 0
  for i in 1.until(0):
    inc counter
  check counter == 0
  #
  counter = 0
  for i in 1.until(-5):
    inc counter
  check counter == 0

test "last with sequence":
  let numbers = @[3, 4, 5, 6]
  check numbers.last == 6

test "last with ASCII strings":
  let s = "Nim"
  check s.lastAscii == 'm'

test "last with Unicode strings":
  let name = "László"
  check $(name.lastRune) == "ó"

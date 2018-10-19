import unittest

import sequtils

import pykot


# ############
suite "pykot":
# ############
  test "lastIndex with sequences":
    let empty = newSeq[int]()
    check empty.lastIndex == -1
    check @[9].lastIndex == 0
    check @[1, 6, 4, 8].lastIndex == 3
    
  test "last with sequence":
    let numbers = @[3, 4, 5, 6]
    check numbers.last == 6
  
  test "indices with sequences":
    let empty = newSeq[int]()
    check toSeq(indices(empty)) == empty
    check toSeq(indices(@[9])) == @[0]
    check toSeq(indices(@[3, 4, 5])) == @[0, 1, 2]
  
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

  test "pyRange(b)":
    var
      res = newSeq[int]()
    for i in pyRange(5):
      res.add(i)
    check res == @[0, 1, 2, 3, 4]

  test "pyRange(a, b)":
    var
      res = newSeq[int]()
    for i in pyRange(5, 8):
      res.add(i)
    doAssert res == @[5, 6, 7]

  test "pyRange(a, b, step)":
    var
      res = newSeq[int]()
    for i in pyRange(0, 9, 3):
      res.add(i)
    doAssert res == @[0, 3, 6]

  # test "loop":
  #   var cnt: int

  #   cnt = 0
  #   loop:
  #     break
  #   check cnt == 0

  #   cnt = 0
  #   loop:
  #     inc cnt
  #     if cnt == 5:
  #       break
  #   check cnt == 5

  #   cnt = 0
  #   loop():
  #     inc cnt
  #     if cnt == 5:
  #       break
  #   check cnt == 5

  test "loop(N)":
    var counter: int

    counter = 0
    loop(5):
      inc counter
    check counter == 5
    #
    counter = 0
    loop(0):
      inc counter
    check counter == 0
    #
    counter = 0
    loop(-3):
      inc counter
    check counter == 0
    #
    counter = 0
    loop(5):
      break
    check counter == 0

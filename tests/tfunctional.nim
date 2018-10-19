import unittest

import strutils
import sugar

import pykot/functional


# #################
suite "functional":
# #################
  test "none":
    var text: string

    text = "HELLO THERE"
    check text.none(isLowerAscii) == true
    text = "HELLo THERE"
    check text.none(isLowerAscii) == false

  test "noneIt":
    var text: string

    text = "HELLO THERE"
    check text.noneIt(it.isLowerAscii) == true
    text = "HELLo THERE"
    check text.noneIt(it.isLowerAscii) == false

  test "partition":
    let
      words = @["mix", "xyz", "apple", "xanadu", "aardvark"]
      partitions = words.partition(s => s[0] == 'x')
    check partitions[0] == @["xyz", "xanadu"]
    check partitions.t == partitions[0]
    check partitions[1] == @["mix", "apple", "aardvark"]
    check partitions.f == partitions[1]

  test "partitionIt":
    let
      temperatures = @[-272.15, -2.0, 24.5, 44.31, 99.8, -113.44]
      partitions = temperatures.partitionIt(it < 50 and it > -10)
    check partitions[0] == @[-2.0, 24.5, 44.31]
    check partitions.t == partitions[0]
    check partitions[1] == @[-272.15, 99.8, -113.44]
    check partitions.f == partitions[1]

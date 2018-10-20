import unittest

import pykot/converters


# #################
suite "converters":
# #################
  test "toInt":
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

  test "toIntPart":
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

import unittest

import sequtils
import unicode

import pykot/strings


# ##############
suite "strings":
# ##############
  test "string concatenation with `+`":
    check "py" + "thon" == "python"

  test "reverse an ASCII string":
    check "".reversedAscii == ""
    check "ab".reversedAscii == "ba"
    check "abcde".reversedAscii == "edcba"

  test "lstrip":
    check "  ab  ".lstrip() == "ab  "
    check "\nab ".lstrip("\n") == "ab "
    check "\t\nab ".lstrip("\n") == "\t\nab "
    check "\t\nab ".lstrip("\n\t") == "ab "
    check "\t\nab".lstrip("\t\n") == "ab"
    check "\t\n ab ".lstrip("\t\n") == " ab "

  test "rstrip":
    check "  hello  ".rstrip() == "  hello"
    check "  hello \n".rstrip({'\n'}) == "  hello "
    check "  hello \n".rstrip("\n") == "  hello "
    check "  hello \n".rstrip("\n ") == "  hello"

  test "lastIndex with ASCII strings":
    check "".lastIndexAscii == -1
    check "x".lastIndexAscii == 0
    check "nim".lastIndexAscii == 2

  test "last with ASCII strings":
    let s = "Nim"
    check s.lastAscii == 'm'

  test "last with Unicode strings":
    let name = "László"
    check $(name.lastRune) == "ó"    # `import unicode` for this to work!

  test "lchop":
    let s = "ABcde"
    check s.lchop("AB") == "cde"
    check s.lchop("XXX") == "ABcde"

  test "rchop":
    let fname = "stuff.nim"
    check fname.rchop(".nim") == "stuff"
    check fname.rchop(".jpg") == "stuff.nim"

    let longer = "nim is a great language"
    check longer.rchop("uage") == "nim is a great lang"

  test "indices with strings":
    let empty = newSeq[int]()
    check toSeq("".indicesAscii()) == empty
    check toSeq("nim".indicesAscii()) == @[0, 1, 2]

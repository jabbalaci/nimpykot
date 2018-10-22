import unittest

import sequtils
import unicode

import pykot/strings


# ##############
suite "strings":
# ##############
  test "test PkString":
    check PkString.ascii_letters.len > 0
    check PkString.ascii_lowercase.len > 0
    check PkString.ascii_uppercase.len > 0
    check PkString.digits.len > 0
    check PkString.hexdigits.len > 0
    check PkString.whitespace.len > 0

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

  test "lastIndex of an ASCII string":
    check "".lastIndexAscii == -1
    check "x".lastIndexAscii == 0
    check "nim".lastIndexAscii == 2

  test "last character of an ASCII string":
    let s = "Nim"
    check s.lastAscii == 'm'

  test "last unicode char (rune) of a string":
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

  test "indices of an ASCII string":
    let empty = newSeq[int]()
    check toSeq("".indicesAscii()) == empty
    check toSeq("nim".indicesAscii()) == @[0, 1, 2]

  test "isPalindromeAscii":
    check "abba".isPalindromeAscii == true
    check "".isPalindromeAscii == true
    check "abcd".isPalindromeAscii == false
    check "á..á".isPalindromeAscii == false
    
  test "isPalindrome":
    check "abba".isPalindrome == true
    check "".isPalindrome == true
    check "abcd".isPalindrome == false
    check "á..á".isPalindrome == true

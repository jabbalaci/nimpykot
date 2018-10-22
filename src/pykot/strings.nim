import sequtils
import strutils
import unicode

## String manipulations.


# #######
# Types #
# #######

type
  JabbaString = tuple
    ascii_letters: string
    ascii_lowercase: string
    ascii_uppercase: string
    digits: string
    hexdigits: string
    # printable: string
    # punctuation: string
    whitespace: string


# ########
# Consts #
# ########

# from Python 3.7.0
# PkString stands for "PyKot String", since "string" is a built-in type of Nim
const PkString*: JabbaString = (
  ascii_letters: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",
  ascii_lowercase: "abcdefghijklmnopqrstuvwxyz",
  ascii_uppercase: "ABCDEFGHIJKLMNOPQRSTUVWXYZ",
  digits: "0123456789",
  hexdigits: "0123456789abcdefABCDEF",
  # printable: "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~ \t\n\r\x0b\x0c",
  # punctuation: "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~",
  whitespace: " \t\n\r\x0b\x0c"
)
  ## Mimics Python's ``string`` module. Since ``string`` is a built-in type in Nim,
  ## it was renamed to PkString (PyKot String).
  ##
  ## Usage example: ``PkString.ascii_lowercase``.
  ## PkString is a tuple.


# #######
# Funcs #
# #######

func `+`*(s, t: string): string =
  ## Concatenates ``s`` and ``t`` into a string.
  ##
  ## Mimicking Python.
  runnableExamples:
    doAssert "py" + "thon" == "python"

  s & t

func reversedAscii*(s: string): string =
  ## Reverse an ASCII string.
  ##
  ## It returns a reversed copy.
  runnableExamples:
    doAssert "hello".reversedAscii == "olleh"

  result = s

  var
    i = result.low
    j = result.high

  while i < j:
    swap(result[i], result[j])
    inc i
    dec j

func isPalindromeAscii*(s: string): bool =
  ## Decide if a string is a palindrome or not.
  ##
  ## It works with ASCII strings only.
  runnableExamples:
    doAssert "abba".isPalindromeAscii == true
    doAssert "".isPalindromeAscii == true
    doAssert "abcd".isPalindromeAscii == false
    doAssert "á..á".isPalindromeAscii == false

  s == reversedAscii(s)

func isPalindrome*(s: string): bool =
  ## Decide if a string is a palindrome or not.
  ##
  ## It works with Unicode strings too.
  runnableExamples:
    doAssert "abba".isPalindrome == true
    doAssert "".isPalindrome == true
    doAssert "abcd".isPalindrome == false
    doAssert "á..á".isPalindrome == true

  s == s.reversed

func lstrip*(s: string, chars: set[char] = Whitespace): string =
  ## Strips leading chars from ``s`` and returns the resulting string.
  ##
  ## If ``chars`` are not specified, leading whitespaces are removed.
  ## Specify ``chars`` as a set of chars (bitset).
  runnableExamples:
    doAssert "  ab  ".lstrip() == "ab  "

  s.strip(leading=true, trailing=false, chars=chars)

func lstrip*(s: string, chars: string): string =
  ## Strips leading chars from ``s`` and returns the resulting string.
  ##
  ## Specify chars in a string. The string is treated as a set of chars,
  ## just like Python's ``lstrip()``.
  runnableExamples:
    doAssert "\nab ".lstrip("\n") == "ab "
    doAssert "\t\nab ".lstrip("\n") == "\t\nab "
    doAssert "\t\nab ".lstrip("\n\t") == "ab "
    doAssert "\t\nab".lstrip("\t\n") == "ab"
    doAssert "\t\n ab ".lstrip("\t\n") == " ab "

  var bs: set[char] = {}
  for c in chars:
    bs = bs + {c}
  s.strip(leading=true, trailing=false, chars=bs)


func rstrip*(s: string, chars: set[char] = Whitespace): string =
  ## Strips trailing chars from ``s`` and returns the resulting string.
  ##
  ## If ``chars`` are not specified, trailing whitespaces are removed.
  ## Specify ``chars`` as a set of chars (bitset).
  runnableExamples:
    doAssert "  ab  ".rstrip() == "  ab"

  s.strip(leading=false, trailing=true, chars=chars)

func rstrip*(s: string, chars: string): string =
  ## Strips trailing ``chars`` from ``s`` and returns the resulting string.
  ##
  ## Specify ``chars`` in a string. The string is treated as a set of chars,
  ## just like Python's ``rstrip()``.
  runnableExamples:
    doAssert "  ab\n".rstrip("\n") == "  ab"
    doAssert "  ab\t\n".rstrip("\n") == "  ab\t"
    doAssert "  ab\t\n".rstrip("\n\t") == "  ab"
    doAssert "  ab\t\n".rstrip("\t\n") == "  ab"
    doAssert "  ab  \t\n".rstrip("\t\n") == "  ab  "

  var bs: set[char] = {}
  for c in chars:
    bs = bs + {c}
  s.strip(leading=false, trailing=true, chars=bs)

func lastIndexAscii*(s: string): int =
  ## Return the index of the last character of a string.
  ##
  ## It works correctly only with an ASCII string.
  runnableExamples:
    let
      s = "Alice"
    doAssert s.lastIndexAscii == 4

  high(s)

func lastAscii*(s: string): char =
  ## Return the last character of a string.
  ## The returned value is a char (byte).
  ##
  ## If the last character is a non-ASCII character,
  ## use the function ``lastRune``.
  runnableExamples:
    let name = "Nim"
    doAssert name.lastAscii == 'm'

  s[^1]

func lastRune*(s: string): Rune =
  ## Return the last Unicode character of a string.
  ## The returned value is a Rune.
  ##
  ## If the last character is an ASCII character,
  ## use the function ``lastAscii``.
  runnableExamples:
    import unicode
    let name = "Alizé"
    doAssert $(name.lastRune) == "é"

  toSeq(s.runes)[^1]

func lchop*(s, sub: string): string =
  ## Remove ``sub`` from the beginning of ``s``.
  runnableExamples:
    let s = "ABcde"
    doAssert s.lchop("AB") == "cde"
    doAssert s.lchop("XXX") == "ABcde"

  if s.startsWith(sub):
    s[sub.len .. s.high]
  else:
    s

func rchop*(s, sub: string): string =
  ## Remove ``sub`` from the end of ``s``.
  runnableExamples:
    let fname = "stuff.nim"
    doAssert fname.rchop(".nim") == "stuff"
    doAssert fname.rchop(".jpg") == "stuff.nim"
    let longer = "nim is a great language"
    doAssert longer.rchop("uage") == "nim is a great lang"

  if s.endsWith(sub):
    s[0 ..< ^sub.len]
  else:
    s


# ###########
# Iterators #
# ###########

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

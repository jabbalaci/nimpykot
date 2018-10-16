import httpclient    # get_page() needs it
import strutils
import sequtils
import unicode
import rdstdin       # inputExtra() needs it
import os            # touch() needs it


# #######
# Procs #
# #######

proc input*(prompt: string = ""): string =
  ## Python's `input()` function, i.e. read a line from the stdin.
  ##
  ## You can also specify a prompt.
  ##
  ## .. code-block:: nim
  ##
  ##     let name = input("Name: ")

  stdout.write(prompt)
  stdin.readLine()

proc inputExtra*(prompt: string = ""): string =
  ## Like Python's `input()` function. Arrows also work.
  ##
  ## You can also specify a prompt.
  ## The extra thing is that the arrows also work, like in Bash.
  ## In Python you can have the same effect if you `import readline`.
  ## If the user presses Ctrl+C or Ctrl+D, an EOFError exception is raised
  ## that you catch on the caller side.
  ##
  ## .. code-block:: nim
  ##
  ##     try:
  ##       let name = input("Name: ")
  ##     except EOFError:
  ##       echo "Ctrl+D was pressed"
  var line: string = ""
  let val = readLineFromStdin(prompt, line)    # line is modified
  if not val:
    raise newException(EOFError, "abort")
  line

proc touch*(fname: string): bool =
  ## Create an empty file if the file doesn't exist.
  ##
  ## Return true, if the file exists. Return false, if the empty file was not created.
  ## If the file exists, its date attribute won't be updated, thus it's simpler
  ## than the Unix touch command.
  if existsFile(fname):
    return true
  # else
  writeFile(fname, "")
  existsFile(fname)

proc get_page*(url: string): string =
  ## Fetch a web page and return its content.
  ##
  ## In case of error, return an empty string.
  let client = newHttpClient()
  try:
    client.getContent(url)
  except:
    ""

proc which*(fname: string): string =
  ## Find a given file in the PATH and return its full path.
  ##
  ## If not found, return an empty string.
  let
    sep = if defined(windows): ";" else: ":"
    dirs = getEnv("PATH").split(sep)

  for dir in dirs:
    let path = joinPath(dir, fname)
    if existsFile(path):
      return path
  #
  return ""    # not found


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

func lastIndex*[T](a: seq[T]): int =
  ## Return the index of the last element of a sequence.
  runnableExamples:
    let
      a = @[4, 8, 3, 9]
    doAssert a.lastIndex == 3

  high(a)

func lastIndexAscii*(s: string): int =
  ## Return the index of the last character of a string.
  ##
  ## It works correctly only with an ASCII string.
  runnableExamples:
    let
      s = "Alice"
    doAssert s.lastIndexAscii == 4

  high(s)

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

func `+`*(s, t: string): string =
  ## Concatenates s and t into a string.
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

func lstrip*(s: string, chars: set[char] = Whitespace): string =
  ## Strips leading chars from s and returns the resulting string.
  ##
  ## If chars are not specified, leading whitespaces are removed.
  ## Specify chars as a set of chars (bitset).
  runnableExamples:
    doAssert "  ab  ".lstrip() == "ab  "

  s.strip(leading=true, trailing=false, chars=chars)

func lstrip*(s: string, chars: string): string =
  ## Strips leading chars from s and returns the resulting string.
  ##
  ## Specify chars in a string. The string is treated as a set of chars,
  ## just like Python's lstrip().
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
  ## Strips trailing chars from s and returns the resulting string.
  ##
  ## If chars are not specified, trailing whitespaces are removed.
  ## Specify chars as a set of chars (bitset).
  runnableExamples:
    doAssert "  ab  ".rstrip() == "  ab"

  s.strip(leading=false, trailing=true, chars=chars)

func rstrip*(s: string, chars: string): string =
  ## Strips trailing chars from s and returns the resulting string.
  ##
  ## Specify chars in a string. The string is treated as a set of chars,
  ## just like Python's rstrip().
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

template none*[T](s: openArray[T], pred: proc(x: T): bool {.closure.}): bool =
  ## Iterates through a container and checks if no item fulfills the predicate.
  runnableExamples:
    let numbers = @[1, 4, 5, 8, 9, 7, 4]
    assert none(numbers, proc (x: int): bool = x > 10) == true
    assert none(numbers, proc (x: int): bool = x > 5) == false

  not sequtils.any(s, pred)

template noneIt*(s, pred: untyped): bool =
  ## Iterates through a container and checks if no item fulfills the predicate.
  runnableExamples:
    let numbers = @[1, 4, 5, 8, 9, 7, 4]
    assert noneIt(numbers, it > 10) == true
    assert noneIt(numbers, it > 5) == false

  not sequtils.anyIt(s, pred)

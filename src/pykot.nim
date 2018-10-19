import sequtils


# #######
# Types #
# #######


# ########
# Consts #
# ########


# #######
# Procs #
# #######


# #######
# Funcs #
# #######

func lastIndex*[T](a: seq[T]): int =
  ## Return the index of the last element of a sequence.
  runnableExamples:
    let
      a = @[4, 8, 3, 9]
    doAssert a.lastIndex == 3

  high(a)

func last*[T](a: seq[T]): T =
  ## Last element of a sequence.
  runnableExamples:
    let numbers = @[2, 7, 4, 9]
    doAssert numbers.last == 9

  a[^1]


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

iterator pyRange*(b: int): int =
  ## An iterator that goes from `0` (incl.) until `b` (excl.).
  ##
  ## Mimics Python's `range()`. `system.range` exists, so it had to be renamed.
  runnableExamples:
    var
      res = newSeq[int]()
    for i in pyRange(5):
      res.add(i)
    doAssert res == @[0, 1, 2, 3, 4]

  var curr = 0
  while curr < b:
    yield curr
    inc curr

iterator pyRange*(a, b: int, step: Positive = 1): int =
  ## An iterator that goes from `a` (incl.) until `b` (excl.).
  ## `step` is optional and must be >= 1.
  ##
  ## Mimics Python's `range()`. `system.range` exists, so it had to be renamed.
  ## Negative step is not supported. Use `countdown` in that case.
  runnableExamples:
    var
      res = newSeq[int]()
    for i in pyRange(5, 8):
      res.add(i)
    doAssert res == @[5, 6, 7]

  var curr = a
  while curr < b:
    yield curr
    curr += step


# ###########
# Templates #
# ###########

# template loop*(body: untyped): untyped =
#   ## Infinite loop.
#   runnableExamples:
#     var cnt: int
    
#     cnt = 0
#     loop():
#       inc cnt
#       if cnt == 5:
#         break
#     doAssert cnt == 5
#     #
#     cnt = 0
#     loop:
#       break
#     doAssert cnt == 0

#   while true:
#     body

template loop*(times: static[Natural], body: untyped): untyped =
  ## Execute the body in a loop N times, i.e. repeat the body N times.
  runnableExamples:
    var cnt = 0
    loop(5):
      inc cnt
    doAssert cnt == 5

  for _ in 0 ..< times:
    body

import sequtils


# #######
# Funcs #
# #######

func partition*[T](s: openArray[T], pred: proc(x: T): bool {.closure.}):
  tuple[t: seq[T], f: seq[T]] {.inline.} =
  ## Returns a tuple that contains two sequences.
  ## The first sequence contains the items that fulfill the predicate.
  ## The second sequence contains the items that do not fulfill the predicate.
  ##
  ## In the tuple the two sequences are called `t` and `f`, which stand for
  ## true and false, respectively, indicating that the predicate is true / false
  ## for the elements of the sequences.
  runnableExamples:
    let
      words = @["mix", "xyz", "apple", "xanadu", "aardvark"]
      partitions = words.partition(proc(s: string): bool = s[0] == 'x')
    assert partitions[0] == @["xyz", "xanadu"]
    assert partitions.t == partitions[0]
    assert partitions[1] == @["mix", "apple", "aardvark"]
    assert partitions.f == partitions[1]

  var
    t = newSeq[T]()
    f = newSeq[T]()
  for i in 0 ..< s.len:
    if pred(s[i]):
      t &= s[i]
    else:
      f &= s[i]
  (t: t, f: f)


# ###########
# Templates #
# ###########

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

template partitionIt*[T](s: openArray[T], pred: untyped):
  tuple[t: seq[T], f: seq[T]] =
  ## Returns a tuple that contains two sequences.
  ## The first sequence contains the items that fulfill the predicate.
  ## The second sequence contains the items that do not fulfill the predicate.
  ##
  ## In the tuple the two sequences are called `t` and `f`, which stand for
  ## true and false, respectively, indicating that the predicate is true / false
  ## for the elements of the sequences.
  runnableExamples:
    let
      temperatures = @[-272.15, -2.0, 24.5, 44.31, 99.8, -113.44]
      partitions = temperatures.partitionIt(it < 50 and it > -10)
    assert partitions[0] == @[-2.0, 24.5, 44.31]
    assert partitions.t == partitions[0]
    assert partitions[1] == @[-272.15, 99.8, -113.44]
    assert partitions.f == partitions[1]

  var
    t = newSeq[T]()
    f = newSeq[T]()
  for it {.inject.} in items(s):
    if pred:
      t &= it
    else:
      f &= it
  (t: t, f: f)

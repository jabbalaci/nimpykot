import random

randomize()

## To avoid confusion with the ``random`` module from the stdlib,
## it's called ``jrandom``, which stands for "jabba's random" module.


proc shuffled*[T](x: seq[T]): seq[T] =
  ## Swaps the positions of elements in a sequence randomly.
  ## Returns a shuffled copy; the input sequence is NOT changed.
  runnableExamples:
    let
      nums = @[1, 2, 3, 4]
      res = shuffled(nums)
    doAssert (res.len == nums.len) and (nums == @[1, 2, 3, 4])

  var copy = x
  copy.shuffle()
  return copy

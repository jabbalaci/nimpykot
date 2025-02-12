import times

## Measuring the wall-clock time. Example:
##
## .. code-block:: nim
##
##   import os
##
##   let timer = Timer()
##
##   withTimer(timer):
##     sleep(2_000)    # 2 seconds
##
##   echo "Elapsed time: $1".format(timer.elapsedTime)

# class Timer ###############################################################

type
  Timer* = ref object
    start: float
    stop: float

proc elapsedTime*(self: Timer): float =
  self.stop - self.start

# ###########################################################################

template withTimer*(timer: Timer, body: untyped) =
  timer.start = epochTime()
  body
  timer.stop = epochTime()

import strutils

# #######
# Funcs #
# #######

func prettyNum*(n: int, sep=','): string =
  ## Prettify a number by adding separators at
  ## the positions of thousands.
  ##
  ## With the optional parameter `sep`, you can set the separator character.
  runnableExamples:
    doAssert prettyNum(2018) == "2,018"
    doAssert prettyNum(1_234_567) == "1,234,567"

  insertSep($n, sep=sep)

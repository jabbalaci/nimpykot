import os


# #######
# Types #
# #######

type
  JabbaSys = tuple
    argv: seq[string]


# ######
# Vars #
# ######

proc getArgv(): seq[string] =
  result &= getAppFilename()
  for i in 1 .. paramCount():
    result &= paramStr(i)

var sys*: JabbaSys = (
  argv: getArgv()
)
  ## Mimics Python's `sys.argv`. It contains the file name and the parameters,
  ## just like in C or Python.
  ##
  ## `sys.argv` can be modified in Python, that's why it's a `var`.

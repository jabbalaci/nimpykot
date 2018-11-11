import os
import strutils

## Working in the file system, e.g. create an empty file.


# #######
# Procs #
# #######

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


# ###########
# Templates #
# ###########

template withFile*(f: untyped, filename: string, mode: FileMode, body: untyped): typed =
  ## Open a file similarly to Python's ``with`` block.
  ##
  ## Reading a file line by line:
  ##
  ## .. code-block:: nim
  ##
  ##      withFile(f, "input.txt", fmRead):
  ##        for line if f.lines:
  ##          echo line
  ##
  ## Writing to a file:
  ##
  ## .. code-block:: nim
  ##
  ##      withFile(f, "out.txt", fmWrite):
  ##        f.writeLine("line 1")
  ##        f.writeLine("line 2")
  let fn = filename
  var f: File
  if open(f, fn, mode):
    try:
      body
    finally:
      close(f)
  else:
    echo "Error: cannot open " & fn

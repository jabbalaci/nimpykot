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

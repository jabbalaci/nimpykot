import rdstdin


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

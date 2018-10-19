import unittest

import pykot/process


# ##############
suite "process":
# ##############
  test "exit status":
    if defined(windows):
      check execute_command("help.exe > NUL") == 1
    else:
      check execute_command("date") == 0

  test "get the output of a process":
    let text =
      if defined(windows):
        get_simple_cmd_output("help.exe")
      else:
        get_simple_cmd_output("date")
        
    check text.len > 0

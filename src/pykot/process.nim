import osproc
import strformat

# #######
# Procs #
# #######

proc execute_command*(cmd: string, debug = true): int =
  ## Execute a simple external command and return its exit status.
  if debug:
    echo &"# {cmd}"

  execCmd(cmd)

proc get_simple_cmd_output*(cmd: string): string =
  ## Execute a simple external command and return its output.
  execProcess(cmd)

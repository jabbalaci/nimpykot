# import strformat
import osproc
import streams

# import pykot/[process, fs]
import pykot/process

proc setClipboardText*(text: string): bool =
  let p = startProcess("xsel", args = ["-bi"], options = {poUsePath, poStderrToStdout})
  p.inputStream.write(text)
  p.inputStream.close()
  let exitCode = p.waitForExit()
  p.close()
  return exitCode == 0

proc getClipboardText*(): string =
  let cmd = "xsel -bo"
  get_simple_cmd_output(cmd, right_strip = true)

# when isMainModule:
#   check_required_programs(@["xsel"])
#   # Example of writing to clipboard
#   let textToWrite = "Hello from Nim! (Linux)"
#   if setClipboardText(textToWrite):
#     echo &"Successfully wrote to clipboard: '{textToWrite}'"
#   else:
#     echo "Failed to write to clipboard"

#   # Example of reading from clipboard
#   echo &"Reading from clipboard: '{getClipboardText()}'"

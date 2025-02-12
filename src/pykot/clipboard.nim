import pykot/fs

when defined(windows):
  import pykot/clipboard/windows
  proc getClipboardText*(): string =
    windows.getClipboardText()
  proc setClipboardText*(text: string): bool =
    windows.setClipboardText(text)
else:  # Linux
  check_required_programs(@["xsel"], halt=true)
  import pykot/clipboard/linux
  proc getClipboardText*(): string =
    linux.getClipboardText()
  proc setClipboardText*(text: string): bool =
    linux.setClipboardText(text)

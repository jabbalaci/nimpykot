when defined(windows):
  import pykot/clipboard/windows
  proc getClipboardText*(): string =
    windows.getClipboardText()
  proc setClipboardText*(text: string): bool =
    windows.setClipboardText(text)
elif defined(linux):
  import pykot/fs
  check_required_programs(@["xsel"], halt=true)
  import pykot/clipboard/linux
  proc getClipboardText*(): string =
    linux.getClipboardText()
  proc setClipboardText*(text: string): bool =
    linux.setClipboardText(text)
elif defined(macos) or defined(macosx):
  import pykot/fs
  check_required_programs(@["pbcopy", "pbpaste"], halt=true)
  import pykot/clipboard/macos
  proc getClipboardText*(): string =
    macos.getClipboardText()
  proc setClipboardText*(text: string): bool =
    macos.setClipboardText(text)
else:
  echo "Error: unsupported OS"
  quit(1)

import unittest

import pykot/clipboard


# ##############
suite "clipboard":
# ##############
  test "which":
    let backup = getClipboardText()
    #
    let text = "hello nim"
    discard setClipboardText(text)
    check getClipboardText() == text
    #
    discard setClipboardText("")
    check getClipboardText().len == 0
    #
    discard setClipboardText(backup)
    check getClipboardText() == backup

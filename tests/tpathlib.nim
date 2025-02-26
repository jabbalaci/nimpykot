import unittest

import pykot/pathlib


# ##############
suite "pathlib":
# ##############
  test "test Python":
    let p = Path("/usr/lib/python2.5/gopherlib.py")
    check p.parent == Path("/usr/lib/python2.5")
    check p.name == "gopherlib.py"
    check p.suffix == ".py"
    check p.stem == "gopherlib"
    let q = p.parent / (p.stem & p.suffix)
    check q == p

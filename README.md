NimPyKot
========

[![Build Status](https://travis-ci.org/jabbalaci/nimpykot.svg?branch=master)](https://travis-ci.org/jabbalaci/nimpykot)

Porting some Python / Kotlin features to Nim.

Installation
------------

```bash
$ nimble install pykot
```

To install the latest development version, issue the following command:

```bash
$ nimble install "https://github.com/jabbalaci/nimpykot@#head"
```

With `nimble uninstall pykot` you can remove the package.

API Documentation
-----------------

See here: https://jabbalaci.github.io/nimpykot/ .

Notes
-----

Similar projects: https://github.com/search?q=nimpylib&type=repositories

Sample
------

Take an integer and reverse it. The result must also be an integer.
Example: 1977 → 7791.

```nim
import unicode
import pykot/converters

proc reverse_number(n: int): int =
  n.toStr().reversed().toInt()

let n = 2018

echo n                    # 2018
echo reverse_number(n)    # 8102
```

See the [samples/](samples) directory for more examples.

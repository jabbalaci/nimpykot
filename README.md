NimPyKot
========

Porting some Python / Kotlin features to Nim.

Installation
------------

```bash
$ nimble install pykot
```

Or, simply copy the file `src/pykot.nim` to your project folder and import it.

Notes
-----

* examples: [tests/test_pykot.nim](tests/test_pykot.nim)
* docs: [docs/pykot.html](https://htmlpreview.github.io/?https://github.com/jabbalaci/nimpykot/blob/master/docs/pykot.html)

The project was inspired by <https://github.com/Yardanico/nimpylib>.

Sample
------

Take an integer and reverse it. The result must also be an integer.
Example: 1977 → 7791.

```nim
import unicode
import pykot

proc reverse_number(n: int): int =
  n.toStr().reversed().toInt()

let n = 2018

echo n
echo reverse_number(n)
```

Output:

```
2018
8102
```

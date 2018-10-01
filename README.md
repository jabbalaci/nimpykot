NimExtensions
=============

Porting some Python / Kotlin features to Nim.

Usage: just copy the file `py.nim` to your project folder and import it.

Examples: see the file `py_test.nim`.

The project was inspired by <https://github.com/Yardanico/nimpylib>.

Sample
------

Take an integer and reverse it. The result must also be an integer.
Example: 1977 → 7791.

```nim
import unicode
import py

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

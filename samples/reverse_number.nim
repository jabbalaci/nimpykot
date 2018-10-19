import unicode
import pykot/converters

proc reverse_number(n: int): int =
  n.toStr().reversed().toInt()

let n = 2018

echo n
echo reverse_number(n)

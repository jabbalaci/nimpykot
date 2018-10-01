import pykot
import sequtils
import unicode

let s = "314"

echo str(s)                           # "314"

let a = 2.0
let b = 5

echo b.toFloat / a                    # 2.5

echo int(3.99)                        # 3

echo()

echo toIntPart(3.14)               # 3
echo toIntPart(3.99)               # 3
echo toIntPart(-3.14)              # -3
echo toIntPart(-3.99)              # -3

echo()

let x = 1977
echo x                                # 1977
echo x.toStr.reversed.toInt           # 7791
echo x.toStr().reversed().toInt()     # 7791

echo()

let numbers = @[1, 5, 7]
for i in numbers.indices():
  echo numbers[i]                     # 1, 5, 7

echo()

for i in 0 .. numbers.lastIndex:
  echo numbers[i]                     # 1, 5, 7

echo()

let word = "nim"
for i in word.indices:
  echo word[i]                        # n, i, m

echo()

for i in 0 .. word.lastIndexAscii:
  echo word[i]                        # n, i, m

echo prettyNum(2018)                  # "2,018"

echo()

repeat(3):
  echo "hello"

echo()

for i in 1.until(5):
  echo i

echo()

let li = @[3, 4, 5, 6]
let empty = newSeq[int]()
echo li[^1]

let
  nums = @[2, 5, 8, 4]
  res = toSeq(nums.indices)

echo res

for c in "László":
  echo c


# Prime number spiral with kanji which turns 90 degrees at each prime

Inspired by [the outstanding answers](https://math.stackexchange.com/questions/2072308/help-with-a-prime-number-spiral-which-turns-90-degrees-at-each-prime)
I had the idea of using **CJK characters** to see spiral and numbers at the same time.

![i01](https://i.imgur.com/JiysLpd.png)

![i02](https://i.imgur.com/Ppd045e.png)

SageMath:

```python
from ruamel.yaml import YAML


def step(x: int, y: int,
         d: str, m: Matrix) -> (int, int):
    match d:
        case 'L':
            if m[y, x-1]:
                pass  # visited
            else:
                m[y, x-1] = 1/12045
            return x-2, y
        case 'U':
            if m[y-1, x]:
                pass  # visited
            else:
                m[y-1, x] = 1/12033
            return x, y-2
        case 'R':
            if m[y, x+1]:
                pass  # visited
            else:
                m[y, x+1] = 1/12032
            return x+2, y
        case 'D':
            if m[y+1, x]:
                pass  # visited
            else:
                m[y+1, x] = 1/12037
            return x, y+2


def main() -> int:
    m = matrix(QQ, 1509, 1083, sparse=True)
    y, x = 154, 1066
    drctn = "R"
    for i in (1..39324):
        if m[y, x]:
            pass  # visited
        else:
            m[y, x] = i
        if i.is_prime():
            drctn = {"L": "U", "U": "R", "R": "D", "D": "L"}[drctn]
        x, y = step(x, y, drctn, m)

    #print
    yaml = YAML(typ="safe")
    with open("int2char.yml", "r") as f:
        int2char = yaml.load(f)
    for y in range(1509):
        for x in range(1083):
            if elem := m[y, x]:
                if (d := elem.denominator()) > 1:
                    print(chr(d), end='')
                else:
                    print(int2char[elem], end='')
            else:
                print("\u3000", end='')
        print()
    return 0


if __name__ == "__main__":
    exit(main())
```

![i03](https://i.imgur.com/bMPjDHu.png)


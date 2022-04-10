from ruamel.yaml import YAML


def step(i: int,
         x: int, y: int,
         d: str, m: Matrix) -> (int, int):
    match d:
        case 'L':
            if m[y, x-1]:
                pass  # visited
            else:
                m[y, x-1] = 1/12045 if i < 40_000 else 1/65308
            return x-2, y
        case 'U':
            if m[y-1, x]:
                pass  # visited
            else:
                m[y-1, x] = 1/12033 if i < 40_000 else 1/65372
            return x, y-2
        case 'R':
            if m[y, x+1]:
                pass  # visited
            else:
                m[y, x+1] = 1/12032 if i < 40_000 else 1/65310
            return x+2, y
        case 'D':
            if m[y+1, x]:
                pass  # visited
            else:
                m[y+1, x] = 1/12037 if i < 40_000 else 1/65281
            return x, y+2


def main() -> int:
    Y, X = 1509, 1121
    m = matrix(QQ, Y, X, sparse=True)
    y, x = 154, 1066  # start
    drctn = "R"
    for i in (1..80_000):
        if m[y, x]:
            pass  # visited
        else:
            m[y, x] = i
        if i.is_prime():
            drctn = {"L": "U", "U": "R", "R": "D", "D": "L"}[drctn]
        x, y = step(i, x, y, drctn, m)

    #print
    yaml = YAML(typ="safe")
    with open("int2char.yml", "r") as f:
        int2char = yaml.load(f)
    for y in range(Y):
        for x in range(X):
            if elem := m[y, x]:
                if (d := elem.denominator()) > 1:
                    print(chr(d), end='')
                else:
                    print(int2char[elem % 40_000], end='')
            else:
                print("\u3000", end='')
        print()
    return 0


if __name__ == "__main__":
    exit(main())

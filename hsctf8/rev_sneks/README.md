### Lấy source code:

```python
└─$ uncompyle6 sneks.pyc
# uncompyle6 version 3.7.4
# Python bytecode 3.8 (3413)
# Decompiled from: Python 3.8.5 (default, Jun 15 2021, 18:58:24)
# [GCC 10.2.1 20210110]
# Embedded file name: sneks.py
# Compiled at: 2021-05-20 02:21:59
# Size of source mod 2**32: 600 bytes
import sys

def f(n):
    if n == 0:
        return 0
    if n == 1 or n == 2:
        return 1
    x = f(n >> 1)
    y = f(n // 2 + 1)
    return g(x, y, not n & 1)

def e(b, j):
    return 5 * f(b) - 7 ** j

def d(v):
    return v << 1

def g(x, y, l):
    if l:
        return h(x, y)
    return x ** 2 + y ** 2

def h(x, y):
    return x * j(x, y)

def j(x, y):
    return 2 * y - x

def main():
    if len(sys.argv) != 2:
        print('Error!')
        sys.exit(1)
    inp = bytes(sys.argv[1], 'utf-8')
    a = []
    for i, c in enumerate(inp):
        a.append(e(c, i))
    else:
        for c in a:
            print((d(c)), end=' ')
            
if __name__ == '__main__':
    main()
# okay decompiling sneks.pyc
```

### Some tests

```bash
└─$ python solve.py viet
20467111114739846236917588 39284137646068711657286 5731478440138170840912 7817740794309872302033684
└─$ python solve.py v
20467111114739846236917588
└─$ python solve.py i
39284137646068711657298
└─$ python solve.py viit
20467111114739846236917588 39284137646068711657286 39284137646068711657202 7817740794309872302033684
```

Số các kí tự bị encrypt vẫn giữ nguyên và bị ảnh hưởng bởi text lenngth. Từ file `output.txt` thì flag sẽ gồm **24** kí tư.

TH số kí tự = nhau như  test case 1 và 4 thì kí tự giống nhau ở cùng vị trí sẽ encrypt ra cùng 1 kết quả.

------

Như vậy mình sẽ khởi tạo chuỗi 24 kí tự giống nhau (minh dat la bien `alphabet`) và brute force encrypt từng kí tự khớp với output thì mình lấy ghép vào flag

```python
def f(n):
    if n == 0:
        return 0
    if n == 1 or n == 2:
        return 1
    x = f(n >> 1)
    y = f(n // 2 + 1)
    return g(x, y, not n & 1)

def e(b, j):
    return 5 * f(b) - 7 ** j

def d(v):
    return v << 1

def g(x, y, l):
    if l:
        return h(x, y)
    return x ** 2 + y ** 2

def h(x, y):
    return x * j(x, y)

def j(x, y):
    return 2 * y - x

output = [9273726921930789991758,166410277506205636620946,836211434898484229672,15005205362068960832084,226983740520068639569752018,4831629526120101632815236,203649875442,1845518257930330962016244,12649370320429973923353618,203569403526,435667762588547882430552,2189229958341597036774,175967536338,339384890916,319404344993454853352,-9165610218896,435667762522082586241848,3542248016531591176336,319401089522705178152,-22797257207834556,12649370160845441339659218,269256367990614644192076,-7819641564003064368,594251092837631751966918564]
alphabet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_{}"
def main():
    flag = ""
    for i in range(len(output)):
        for j in range(len(alphabet)):
            str_ = bytes(alphabet[j] * 24, 'utf-8')
            e_text = [e(c, i) for i, c in enumerate(str_)]
            d_text = [d(c) for c in e_text]
            if(d_text[i] == output[i]):
                flag += alphabet[j]
    print(flag)

if __name__ == '__main__':
    main()
```

### flag

> flag{s3qu3nc35_4nd_5um5}
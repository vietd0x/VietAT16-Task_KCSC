Để có chiếc wu này là nhờ có sự giúp đỡ cực mạnh từ một anh khóa trên `tốt bụng` trong clb :v 

------



### Lấy source code:

```python
└─$ uncompyle6 chall.pyc
# uncompyle6 version 3.7.4
# Python bytecode 3.8 (3413)
# Decompiled from: Python 3.8.5 (default, Jun 15 2021, 18:58:24)
# [GCC 10.2.1 20210110]
# Embedded file name: chall.py
# Compiled at: 2021-04-16 02:21:48
# Size of source mod 2**32: 860 bytes
import random, time
with open('flag.txt') as (f):
    flag = list(f.read())
if len(flag) % 2 == 1:
    flag.append(' ')
x = ['t', 'Y', 'w', 'V', '|', ']', 'u', 'X', '_', '0', 'P', 'k', 'h', 'D', 'A', '4', 'K', '5', 'z',
 'Z', 'G', '7', ';', 'S', ' ', '/', '6', '%', '}', '\\', ',', ':', '>', '#', 'a', '$', '3', '`',
 '+', 'R', 'b', 'H', 'd', 's', '1', 'J', 'L', 'v', '9', '2', 'o', 'M', '<', 'e', '(', 'x', '-',
 'B', 'm', "'", 'y', 'Q', '"', 'W', 'l', '.', 'i', 'O', '^', 'p', '8', 'f', 'F', 'C', '?', 'g',
 '@', 'j', '[', 'r', '!', '=', 'E', '~', '*', 'T', '{', ')', 'U', 'N', 'c', '&', 'n', 'q', 'I']
random.seed(int(time.time()))
for _ in range(20):
    for i in range(len(flag)):
        flag[i] = x[(ord(flag[i]) - 32)]
else:
    random.shuffle(flag)

for i in range(0, len(flag), 2):
    flag[i], flag[i + 1] = flag[(i + 1)], flag[i]
else:
    print(''.join(flag))
# okay decompiling chall.pyc
```

### Brief:

prog trên đọc text từ file `flag.txt` và lưu vào biến `flag` ở dạng **list**. Nếu số ptu của `flag` là số lẻ thì thêm kí tự `' '` . Sau đó encrypt list `flag`. Đề cho file `output.txt` là kết quả của chương trình trên vs đầu vào là flag

### Phân tích cách encypt:

```python
# seed
random.seed(int(time.time()))
# có thể thấy loop này khi encrypt ko phụ thuộc vào flag length 
# cũng như kết quả của kí tự tại 1 vị trí bất kỳ ko bị ảnh hưởng bởi kí tự ở ví trí khác của flag
for _ in range(20):
    for i in range(len(flag)):
        flag[i] = x[(ord(flag[i]) - 32)]
# zờ mới đổi chỗ các kí tự = shuffle vs seed là time
random.shuffle(flag)
# hàm này swap từng đôi một của list flag
for i in range(0, len(flag), 2):
    flag[i], flag[i + 1] = flag[(i + 1)], flag[i]
```

### Rev time: 

Có output nên mình sẽ đi từ dưới chương trình lên. Ta cần biết seed = `int(time.time())` hay thời điểm người ra đề run prog ra output. Nên mình sẽ lấy thời điểm hiện tại giảm dần đến khi khớp vs thời điểm đó.

```
>>> import time
>>> int(time.time())
1618517331 # my current time
```

```python
import random
output = list('QQ.ap(OOOaQa.a($/FF.F/ZOZ..aQaQ/aa(a(ZZaaF.Q^FaZ,S/..(^]aF.FF.pFF-(==SFa/aOo.=/aFM/,.,Z=/aF/aQ/*<Q(^-OSZOO=a]Q](Q<].a~/ao/aYZaF=aQa]Q^FOZFsQn/^FOh.*aZ.OaaO/(Q.SZ</ QQ,a(OFaFF((QQQaQQ/^/Q.O-F(Z(=gQQ=k,OSF=F.a/]Q=Z(Qa(ao=a:ZQ/QpJ]/QQF.=FZ]QkFS^=Q:QQZQFa=."OS(=^Q.^Ja/(/Z^]F:]//./.Q=F=Ya/SO/]Oas=apS=(..)(.aF/(oZ(a/~.,,ZZZ/Oq=(.QF":.|O($FZ./(]]FO]FO.Oo"F+QO/FqY/Z-(a.=/F/aa/.=OZOFQ(=Z./pOa((O]..Q/]Q((a(]/aaSZJ.Q(*F]<//Fa/|]QFQZ(=S.ZQQZOFQa:Q/aQO=(]..a/^(QOQoF////(^kF-a-')
for i in range(0, len(output), 2):
    output[i], output[i + 1] = output[(i + 1)], output[i]

x = ['t', 'Y', 'w', 'V', '|', ']', 'u', 'X', '_', '0', 'P', 'k', 'h', 'D', 'A', '4', 'K', '5', 'z',
 'Z', 'G', '7', ';', 'S', ' ', '/', '6', '%', '}', '\\', ',', ':', '>', '#', 'a', '$', '3', '`',
 '+', 'R', 'b', 'H', 'd', 's', '1', 'J', 'L', 'v', '9', '2', 'o', 'M', '<', 'e', '(', 'x', '-',
 'B', 'm', "'", 'y', 'Q', '"', 'W', 'l', '.', 'i', 'O', '^', 'p', '8', 'f', 'F', 'C', '?', 'g',
 '@', 'j', '[', 'r', '!', '=', 'E', '~', '*', 'T', '{', ')', 'U', 'N', 'c', '&', 'n', 'q', 'I']
t = 1618517331
while(1000000000 < t):
    random.seed(t)
    index = [i for i in range(len(output))]
    random.shuffle(index)
    dict_ = {}
    for i in range(len(output)):
        dict_[index[i]] = output[i]
    dict1 = [dict_[i] for i in range(len(output))]

    for _ in range(20):
        for i in range(len(output)):
            dict1[i] = chr(x.index(dict1[i]) + 32)
            
    flag = ''.join(dict1)
    if('flag{' in flag):
        print(f"time = {t}: {flag}")
    t -= 1
'''
time = 1618514508: asdfijoewiafj{opfw2eijafewpoi4jfepoijfweapoifejfpoijep2ofjpoeiwajfae}pox{cnkvo3ivnopifiopnqdfaisjiposdfajifoaiweifjeeeeeewpjwefoipwefjpewofijfepoiwefjpofeijefpwoijeoiejepooeiopew flag{71me5t4mp_fun} ijapdiofjaewp_iojnoewnvpoifpoie_wbpaoibjfpaoiwbfoboawebfbiefaowefbjopiaewfjefeb_anieaiebn_faoebf2a2222aniopni2poabn2fbwnifabwfebnibfaepaebfiabfine2a5ebonfifbw8aeniafbe9asd3npoinxclknvokinawp3oinoink2xclnopinevpaoiwenapoiwev41poiawevnpaowevnapwveovinklnzdvslkvnlknpq3pi 
'''
```

### flag

> `flag{71me5t4mp_fun}`


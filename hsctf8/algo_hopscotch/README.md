> Keith wants to play hopscotch, but in order to make things interesting, he decides to use a random number generator to decide the number of squares n to draw for a round of hopscotch. He then creates a hopscotch board on the floor by randomly creating a sequence of ones (one square) and twos (two squares) such that the sum of all the numbers in the sequence is n. Given 1 <= n <= 1000, find the number of valid hopscotch boards (mod 10000) he can create.
>
> Sample Input: 5 Sample Output: 8

chal cho ta 1 số nguyên dương ngẫu nhiên 1 <= n <= 1000. Từ số đó hỏi có thể tạo ra bao nhiêu chuỗi gồm chỉ 1 và 2 khác nhau mà tổng các ptu trong chuỗi = n

Vs sample input: 5 -> output = 8

vs n = 5 thì chuỗi chỉ có thể tạo từ 3 tập {1,2,2} ; {1,1,1,2} và {1,1,1,1}

| 122  | 1112 | 11111 |
| ---- | ---- | ----- |
| 212  | 1121 |       |
| 221  | 1211 |       |
|      | 2111 |       |

=> có thể tạo đc 8 chuỗi TM

------

Từ n mình sẽ tìm các tập = cách tìm tập ít phần tử nhất (hay chứa nhiều '2' nhất)

```python
def MinSequenceOf1_2(n):
	lst = []
    # n le thì thêm 1
	if(n&1):
		lst.append(1)
    # zờ n chẵn r thì thêm n//2 ptu 2 thôi ez
	lst.extend([2]* (n // 2))
	return lst

MinSequenceOf1_2(5) # [1,2,2]
```

Các chuỗi còn lại chỉ việc thay từng vi trí có ptu 2 -> 1 rồi thêm 1 vào cuối list để đảm bảo tổng các ptu = n là được

```
n = 5: [1,2,2] -> [1,1,2,1] -> [1,1,1,1,1]
```

 Mình sẽ để việc này ở hàm **solve()**

------

Để tính sỗ chuỗi khác nhau có thể tạo từ các tập {1,2,2} ; {1,1,1,2} và {1,1,1,1}

Mình sử dụng công thức hoán vị lặp: $\frac{n!}{n_1!  n_2!}$ 

```python
# tinh giai thua n!
def factorial(n):
    return 1 if (n==1 or n==0) else n * factorial(n - 1);
# tính sỗ chuỗi khác nhau có thể
# vd tham so = [1,2,2] thì return 3
def calc(lst):
	n = len(lst)
	count1 = 0
	for i in lst:
		if(i == 1):
			count1 += 1
	fact1 = factorial(count1)     # n1!
	fact2 = factorial(n - count1) # n2!
	factn = factorial(n)          # n!
	return factn // (fact1 * fact2)
```

------

### solve.py

```python
from pwn import *

def MinSequenceOf1_2(n):
	lst = []
	if(n&1):
		lst.append(1)
	lst.extend([2]* (n // 2))
	return lst

def factorial(n):
    return 1 if (n==1 or n==0) else n * factorial(n - 1);

def calc(lst):
	n = len(lst)
	count1 = 0
	for i in lst:
		if(i == 1):
			count1 += 1
	fact1 = factorial(count1)
	fact2 = factorial(n - count1)
	factn = factorial(n)
	return factn // (fact1 * fact2)

def solve(lst):
	sum_ = 0
	index = 0
    # tinh den khi nao list chỉ còn 1 ptu 2
	while(2 in lst):
		if(lst[index] == 2):
			sum_ += calc(lst)
			lst[index] = 1
			lst.append(1)
		else:
			index += 1
    # cộng 1 vì còn TH list toàn phần tử 1 thì chỉ có 1 cách sắp xếp 
	return (sum_+1) % 10000

r = remote('hopscotch.hsc.tf', 1337)
print(r.recvline())
try:
	while True:
		n = int(r.recvline().strip())
		r.sendline(f'{solve(MinSequenceOf1_2(n))}')
		r.recvuntil(': ')
except Exception as err:
    print(err)
    r.recvall()
```

### Run & get flag

```bash
└─$ python3 solve.py
[+] Opening connection to hopscotch.hsc.tf on port 1337: Done
b'== proof-of-work: disabled ==\n'
invalid literal for int() with base 10: b'b"flag{wh4t_d0_y0U_w4nt_th3_fla5_t0_b3?_\'wHaTeVeR_yOu_wAnT\'}\\n"'
[+] Receiving all data: Done (0B)
[*] Closed connection to hopscotch.hsc.tf port 1337
```

### Flag

> flag{wh4t_d0_y0U_w4nt_th3_fla5_t0_b3?_\'wHaTeVeR_yOu_wAnT\'}
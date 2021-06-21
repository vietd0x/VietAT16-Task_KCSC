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
	while(2 in lst):
		if(lst[index] == 2):
			sum_ += calc(lst)
			lst[index] = 1
			lst.append(1)
		else:
			index += 1
	return (sum_+1) % 10000
r = remote('hopscotch.hsc.tf', 1337)
print(r.recvline())
try:
	while True:
		n = int(r.recvline().strip())
		r.sendline(f'{solve(MinSequenceOf1_2(n))}')
		r.recvuntil(': ')
except Exception as err: # I'm lazy to detect the flag, so I'll just catch it...
    print(err)
    r.recvall()
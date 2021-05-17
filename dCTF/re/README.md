![](imgs\re_bell.png)

Mở ida lên tìm hàm **main** và press holy button `F5` :

![main](imgs\main.png)

Biến v5 là tham số của hàm **process** nhưng nó đã đc in ra nên ko quan tâm lắm![we_have_v5](imgs\we_have_v5.png)

Mò vào **process** function và `F5`: [pseudocode with some variables renamed by me]

```c
__int64 __fastcall process(int Known_var)// we have already known this argument before 
{
  int dont_be_0; // [rsp+10h] [rbp-20h]
  int i; // [rsp+14h] [rbp-1Ch]
  __int64 Input; // [rsp+18h] [rbp-18h] BYREF
  __int64 Magic; // [rsp+20h] [rbp-10h]
  unsigned __int64 v6; // [rsp+28h] [rbp-8h]

  v6 = __readfsqword(0x28u); // who care what is this :v
  dont_be_0 = 1;
  for ( i = 1; i <= Known_var; ++i )
  {
    Magic = triangle((unsigned int)Known_var, (unsigned int)i);
    __isoc99_scanf(&unk_AA4, &Input);
    if ( Magic != Input )
      dont_be_0 = 0;
  }
  if ( dont_be_0 == 1 )
    system("cat flag.txt"); // my target
  else
    puts("Better luck next time.");
  return 0LL;
}
```

Về cơ bản thì biến vòng lặp chạy `Known_var` lần và so sánh `Input` ta nhập vs biến `Magic` (result of **triangle** func), nếu khác thì `dont_be_0` = 0. Mục tiêu của ta là sau khi thoát loop `dont_be_0` = 1. Giờ mò vào hàm **triangle(Known_var, i)** xem nào, tiếp tục spam `F5` :![triangle](imgs\triangle.png)

code lại hàm này = python:

```python
def triangle(Known_var, i):
  if ( i >Known_var ):
    return 0
  if ( Known_var == 1 and i == 1 ):
    return 1
  if ( i == 1 ):
    return triangle(Known_var - 1, Known_var - 1)
  v3 = triangle(Known_var,i - 1)
  return v3 + triangle(Known_var - 1, i - 1)
```

Sử dụng pwntool:

```python
# solve.py
from pwn import*

def triangle(Known_var, i):
  if ( i >Known_var ):
    return 0
  if ( Known_var == 1 and i == 1 ):
    return 1
  if ( i == 1 ):
    return triangle(Known_var - 1, Known_var - 1)
  v3 = triangle(Known_var,i - 1)
  return v3 + triangle(Known_var - 1, i - 1)

r = remote('dctf-chall-bell.westeurope.azurecontainer.io', 5311)
Known_var = int(r.recvline()[:-1])
for i in range(1, Known_var+1):
  r.sendline(f'{triangle(Known_var, i)}')
r.interactive()
```

![flag ne](imgs\flag.png)

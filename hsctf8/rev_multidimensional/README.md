Trong main function: `s` là input và đi qua các hàm sau đó đc check xem có bằng chuõi `"hey_since_when_was_time_a_dimension?"` hay không

```java
if (s.length() == 36) { // flag (input) co 36 ki tu
    
    // xếp lần lượt 36 kí tự vào ma trận 6x6
    // theo thứ tự cột từ trái -> phải
    Multidimensional f = new Multidimensional(s);
    
    f.line();
    f.plane();
    f.space(35);
    f.time();
    if (f.check())
```

### rev line() function

```java
public void line_1() {
    char[][] newArr = new char[arr.length][arr[0].length];
    for (int i = 0; i < arr.length; i++) {
        for (int j = 0; j < arr[0].length; j++) {
            int p = i + 1, q = j + 1, f = 0;
            boolean row = i % 2 != 0;
            boolean col = j % 2 != 0;
            if (row) {
                p = i - 1;
                f--;
            } else
                f++;
            if (col) {
                q = j - 1;
                f--;
            } else
                f++;
            newArr[p][q] = (char) (arr[i][j] + f);
        }
    }
    arr = newArr;
}
```

### rev plane() function

hàm này có 2 loop  riêng biệt nên mình sẽ đảo thứ tự thực thi

```java
public void plane_1() {
    int n = arr.length;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            arr[i][j] -= i + n - j;
        }
    }
    for (int i = 0; i < n / 2; i++) {
        for (int j = 0; j < n / 2; j++) {
            // các bạn đối chiếu vs code gỗc sẽ thấy
			// mình chỉ đổi lại thứ tư gán của cái đống này
            char t = arr[i][j];
            arr[i][j] = arr[n - 1 - j][i];
            arr[n - 1 - j][i] = arr[n - 1 - i][n - 1 - j];
            arr[n - 1 - i][n - 1 - j] = arr[j][n - 1 - i];
            arr[j][n - 1 - i] = t;
        }
    }
}
```

### rev space() & time() function

```java
public void space_1(int n) {
    // 35 max index of arr
	// bthuc này chỉ đổi giá trị
	// của từng arr[r][c]
    arr[(35 - n) / 6][(35 - n) % 6] += (n / 6) + (n % 6);
    if (n != 0) {
      n--;
      unspace(n);
    }
}
public void time_1() {
        int[][] t = {{8, 65, -18, -21, -15, 55},
                {8, 48, 57, 63, -13, 5},
                {16, -5, -26, 54, -7, -2},
                {48, 49, 65, 57, 2, 10},
                {9, -2, -1, -9, -11, -10},
                {56, 53, 18, 42, -28, 5}};
        for (int j = 0; j < arr[0].length; j++)
            for (int i = 0; i < arr.length; i++)
                arr[i][j] -= t[j][i];
    }
```

### check()

hàm check() sẽ xdinh kết quả khớp vs chuỗi  "hey_since_when_was_time_a_dimension?" ở dang ma trận 6x6 như ở hàm `Multidimensional(s)`

Mình sẽ sử dụng python script để lấy chuỗi đầu vào [co biet code jav dau :v]

```python
def Multidimensional(s):
	arr = [[0, 0, 0, 0, 0, 0],
		   [0, 0, 0, 0, 0, 0],
		   [0, 0, 0, 0, 0, 0],
		   [0, 0, 0, 0, 0, 0],
		   [0, 0, 0, 0, 0, 0],
		   [0, 0, 0, 0, 0, 0]]	
	for i in range(len(s)):
		arr[i % 6][i//6] = s[i]
	return arr
print(Multidimensional("hey_since_when_was_time_a_dimension?"))
# [['h', 'n', 'e', '_', 'a', 'n'], ['e', 'c', 'n', 't', '_', 's'], ['y', 'e', '_', 'i', 'd', 'i'], ['_', '_', 'w', 'm', 'i', 'o'], ['s', 'w', 'a', 'e', 'm', 'n'], ['i', 'h', 's', '_', 'e', '?']]
```

input của chúng ta: `hne_anecnt_sye_idi__wmioswaemnihs_e?`

### Solution

```java
public class Multidimensional {
    private char[][] arr;

    public Multidimensional(String s) {
        arr = new char[6][6];
        for (int i = 0; i < s.length(); i++) {
            arr[i % 6][i / 6] = s.charAt(i);
        }
    }

    public String check() {
        String s = "";
        for (char[] row : arr)
            for (char c : row)
                s += c;
        return (s);
    }

    public void line_1() {
        char[][] newArr = new char[arr.length][arr[0].length];
        for (int i = 0; i < arr.length; i++) {
            for (int j = 0; j < arr[0].length; j++) {
                int p = i + 1, q = j + 1, f = 0;
                boolean row = i % 2 != 0;
                boolean col = j % 2 != 0;
                if (row) {
                    p = i - 1;
                    f--;
                } else
                    f++;
                if (col) {
                    q = j - 1;
                    f--;
                } else
                    f++;
                newArr[p][q] = (char) (arr[i][j] + f);
            }
        }
        arr = newArr;
    }

    public void plane_1() {
        int n = arr.length;
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                arr[i][j] -= i + n - j;
            }
        }
        for (int i = 0; i < n / 2; i++) {
            for (int j = 0; j < n / 2; j++) {
                char t = arr[i][j];
                arr[i][j] = arr[n - 1 - j][i];
                arr[n - 1 - j][i] = arr[n - 1 - i][n - 1 - j];
                arr[n - 1 - i][n - 1 - j] = arr[j][n - 1 - i];
                arr[j][n - 1 - i] = t;
            }
        }
    }

    public void space_1(int n) {
        arr[(35 - n) / 6][(35 - n) % 6] += (n / 6) + (n % 6);
        if (n != 0) {
            n--;
            space_1(n);
        }
    }

    public void time_1() {
        int[][] t = {{8, 65, -18, -21, -15, 55},
                {8, 48, 57, 63, -13, 5},
                {16, -5, -26, 54, -7, -2},
                {48, 49, 65, 57, 2, 10},
                {9, -2, -1, -9, -11, -10},
                {56, 53, 18, 42, -28, 5}};
        for (int j = 0; j < arr[0].length; j++)
            for (int i = 0; i < arr.length; i++)
                arr[i][j] -= t[j][i];
    }
    
    public static void main(String[] args) {
        String s = "hne_anecnt_sye_idi__wmioswaemnihs_e?";
        Multidimensional f = new Multidimensional(s);
        f.time_1();
        f.space_1(35);
        f.plane_1();
        f.line_1();
        f.check();
        String flag = f.check();
        Multidimensional Flag = new Multidimensional(flag);
        System.out.println(Flag.check());
    }
}
```

### Flag

> flag{th3_g4t3w4y_b3t233n_d1m3n510n5}

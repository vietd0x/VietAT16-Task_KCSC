Từ kết quả trả về của `hot(warm(cool(cold(flag)))) ="4n_3nd0th3rm1c_rxn_4b50rb5_3n3rgy" `. 

có output nên mĩnh sẽ phân tích từ ngoài vào các hàm để tìm flag. Viết các hàm trả về giá trị tham số tương ứng vs output. 

------

Nhờ hàm **hot()** mình sẽ tìm được kết quả của `warm(cool(cold(flag)))` thỏa mãn oụtput

```java
public static String hot_1(String t) {
        int[] adj = {-72, 7, -58, 2, -33, 1, -102, 65, 13, -64,
                21, 14, -45, -11, -48, -7, -1, 3, 47, -65, 3, -18,
                -73, 40, -27, -73, -13, 0, 0, -68, 10, 45, 13};
        String s = "";
        for (int i = 0; i < t.length(); i++)
            s += (char) (t.charAt(i) - adj[i]);
        return s;
    }
String warm(cool(cold(flag))) = hot_1("4n_3nd0th3rm1c_rxn_4b50rb5_3n3rgy")
// |g1c3[s]_^nyyk0u_GyJ}~l3nwh:l
```

zờ phân tich hàm **warm()** vs kết quả trả về ở trên

```
Chuỗi t (đầu vào) chia làm 2 chuỗi con là a và t1:
 + String a = t[:'l'] - kí tự đầu chuỗi t -> kí tự 'l' của chuỗi t (nếu có)
 + String t1 = phần còn lại đằng sau.
Chuỗi t1 lại chia làm 2 chuỗi con b và c:
 + String b = t1[:'l'] - kí tự đầu chuỗi t1 -> kí tự 'l' của chuỗi t1 (nếu có)
 + String c = phần còn lại đằng sau.
Chuỗi trả về c + b + a = |g1c3[s]_^nyyk0u_GyJ}~l3nwh:l
Chuỗi trả về có 2 kí tự 'l'
=> a = '3nwh:l' ,  c + b = '|g1c3[s]_^nyyk0u_GyJ}~l'
```

```java
// hàm này sẽ in ra tất cả TH có thể của cool(cold(flag))
public static void warm_1(String s) {
    s = hot_1(s); 
    String a = s.substring(27);
    String b, c;
    for (int i = 0; i < 27; ++i) {
        c = s.substring(0, i + 1);
        b = s.substring(i + 1, 27);
        System.out.println(a + b + c);
    }
}
warm_1(match);
```

Tương tự vs hàm `cool` và `cold`

```java
public static String cool_1(String t) {
    String s = "";
    for (int i = 0; i < t.length(); i++)
        if (i % 2 == 0)
            s += (char) (t.charAt(i) - 3 * (i / 2));
        else
            s += t.charAt(i);
    return s;
}
public static String cold_1(String t) {
    return t.substring(t.length() - 17) + t.substring(0, t.length() - 17);
}
```

### Solve.java

```java
public class WarmupRev {
    public static String cold_1(String t) {
        return t.substring(t.length() - 17) + t.substring(0, t.length() - 17);
    }

    public static String cool_1(String t) {
        String s = "";
        for (int i = 0; i < t.length(); i++)
            if (i % 2 == 0)
                s += (char) (t.charAt(i) - 3 * (i / 2));
            else
                s += t.charAt(i);
        return s;
    }

    public static String hot_1(String t) {
        int[] adj = {-72, 7, -58, 2, -33, 1, -102, 65, 13, -64,
                21, 14, -45, -11, -48, -7, -1, 3, 47, -65, 3, -18,
                -73, 40, -27, -73, -13, 0, 0, -68, 10, 45, 13};
        String s = "";
        for (int i = 0; i < t.length(); i++)
            s += (char) (t.charAt(i) - adj[i]);
        return s;
    }

    public static void warm_1(String s) {
        s = hot_1(s);
        String a = s.substring(27);
        String b, c;
        for (int i = 0; i < 27; ++i) {
            c = s.substring(0, i + 1);
            b = s.substring(i + 1, 27);
            System.out.println(cold_1(cool_1(a + b + c)));
        }
    }

    public static void main(String[] args) {
        String match = "4n_3nd0th3rm1c_rxn_4b50rb5_3n3rgy";
        warm_1(match);
    }
}
```

### Flag

> flag{1ncr34s3_1n_3nth4lpy_0f_5y5}


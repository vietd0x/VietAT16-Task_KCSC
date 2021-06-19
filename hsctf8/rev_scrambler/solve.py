import random
output = list('QQ.ap(OOOaQa.a($/FF.F/ZOZ..aQaQ/aa(a(ZZaaF.Q^FaZ,S/..(^]aF.FF.pFF-(==SFa/aOo.=/aFM/,.,Z=/aF/aQ/*<Q(^-OSZOO=a]Q](Q<].a~/ao/aYZaF=aQa]Q^FOZFsQn/^FOh.*aZ.OaaO/(Q.SZ</ QQ,a(OFaFF((QQQaQQ/^/Q.O-F(Z(=gQQ=k,OSF=F.a/]Q=Z(Qa(ao=a:ZQ/QpJ]/QQF.=FZ]QkFS^=Q:QQZQFa=."OS(=^Q.^Ja/(/Z^]F:]//./.Q=F=Ya/SO/]Oas=apS=(..)(.aF/(oZ(a/~.,,ZZZ/Oq=(.QF":.|O($FZ./(]]FO]FO.Oo"F+QO/FqY/Z-(a.=/F/aa/.=OZOFQ(=Z./pOa((O]..Q/]Q((a(]/aaSZJ.Q(*F]<//Fa/|]QFQZ(=S.ZQQZOFQa:Q/aQO=(]..a/^(QOQoF////(^kF-a-')

for i in range(0, len(output), 2):
    output[i], output[i + 1] = output[(i + 1)], output[i]

x = ['t', 'Y', 'w', 'V', '|', ']', 'u', 'X', '_', '0', 'P', 'k', 'h', 'D', 'A', '4', 'K', '5', 'z',
 'Z', 'G', '7', ';', 'S', ' ', '/', '6', '%', '}', '\\', ',', ':', '>', '#', 'a', '$', '3', '`',
 '+', 'R', 'b', 'H', 'd', 's', '1', 'J', 'L', 'v', '9', '2', 'o', 'M', '<', 'e', '(', 'x', '-',
 'B', 'm', "'", 'y', 'Q', '"', 'W', 'l', '.', 'i', 'O', '^', 'p', '8', 'f', 'F', 'C', '?', 'g',
 '@', 'j', '[', 'r', '!', '=', 'E', '~', '*', 'T', '{', ')', 'U', 'N', 'c', '&', 'n', 'q', 'I']
t = 1618517331
while(1000000000 < t):
    random.seed(t)
    index = [i for i in range(len(output))]
    random.shuffle(index)
    dict_ = {}
    for i in range(len(output)):
        dict_[index[i]] = output[i]
    dict1 = [dict_[i] for i in range(len(output))]

    for _ in range(20):
        for i in range(len(output)):
            dict1[i] = chr(x.index(dict1[i]) + 32)
    flag = ''.join(dict1)
    if('flag{' in flag):
        print(f"time = {t}: {flag}")
    t -= 1

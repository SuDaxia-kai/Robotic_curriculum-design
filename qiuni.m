function tmuo = qiuni(tmuo)

n = (tmuo(1:3,1)).';
o = (tmuo(1:3,2)).';
a = (tmuo(1:3,3)).';
p = tmuo(1:3,4);
u = tmuo(1:3,1:3);

uT = u.';

tmuo(1:3,1:3) = uT;
tmuo(1,4) = -n*p;
tmuo(2,4) = -o*p;
tmuo(3,4) = -a*p;
end
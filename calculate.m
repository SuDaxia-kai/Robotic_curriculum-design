clear;
clc;
syms C1 S1 C2 S2 C3 S3 C4 S4 C5 S5
syms d1 d2 d3 d4 d5 d6 d7
syms a1 a2 a3 a4 a5 a6 a7
syms nx ny nz ox oy oz ax ay az px py pz
th = [0 0 C1 S1 C2 S2 C3 S3 C4 S4 1 0 C5 S5 1 0];
dz = [d1 0 0 0 d5 0 0];
dx = [0 a2 a3 0 0 0 0];
total = [];
ToDeg = 180/pi;
ToRad = pi/180;
global Link

for i = 2:1:7
%     dz = Link(i).dz;
%     dx = Link(i).dx;
    alf = Link(i).alf;

    C = th(2*i-1);
    S = th(2*i);
    D = dz(i-1);
    A = dx(i-1);
    T = [C, -round(cos(alf))*S,   round(sin(alf))*S,  A*C;
         S,  round(cos(alf))*C,  -round(sin(alf))*C,  A*S;
         0,    round(sin(alf)),     round(cos(alf)),    D;
         0,           0,            0,                  1];
    total = [total;T];
end


T221 = qiuni(total(1:4,:));
Tp25 = qiuni(total(21:24,:));
T322 = qiuni(total(5:8,:));
T5245 = qiuni(total(17:20,:));
T524 = qiuni(total(13:16,:));
T423 = qiuni(total(9:12,:));

E1 = eye(4);
for k = 2:1:6
    E1 = E1*total(4*(k-1)+1:k*4,:);
end
E1 = simplify(E1)

T12p = [nx ox ax px;
        ny oy ay py;
        nz oz az pz;
        0  0  0  1];
final = simplify(T221*T12p*Tp25)

A = [
    0.3084   -0.7912    0.5280  -92.3418
    0.0040   -0.5540   -0.8325  -64.6584
    0.9513    0.2588   -0.1677  133.2563
         0         0         0    1.0000];
pose = A(1:3,1:3);
px = A(1,4);
py = A(2,4);
pz = A(3,4);
[t1,t2,t3,t4,t5] = reverse_5(pose,px,py,pz)



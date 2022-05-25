clear;
clc;
syms C1 S1 C2 S2 C3 S3 C4 S4 C45 S45 C5 S5
a = [0 0 C1 S1 C2 S2 C3 S3 C4 S4 1 0 C5 S5];
total = [];
ToDeg = 180/pi;
ToRad = pi/180;
global Link

for i = 2:1:7
    dz = Link(i).dz;
    dx = Link(i).dx;
    alf = Link(i).alf;

    C = a(2*i-1);
    S = a(2*i);
    T = [C, -round(cos(alf))*S,  round(sin(alf))*S, dx*C;
     S,  round(cos(alf))*C, -round(sin(alf))*C, dx*S;
           0,          round(sin(alf)),          round(cos(alf)),        dz;
           0,                 0,                 0,         1];
      total = [total;T]
end

E = eye(4);
for j = 1:1:6
    E = E*total(4*(j-1)+1:j*4,:);
end


Tp25 = qiuni(total(21:24,:));
T120 = qiuni(total(1:4,:));

tt = T120*E*Tp25
E1 = eye(4);
for j = 2:1:6
    E1 = E1*total(4*(j-1)+1:j*4,:);
end
E1


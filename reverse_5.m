function [th1,th2,th3,th4,th5]=reverse_5(pose,px,py,pz)

ToDeg = 180/pi;
ToRad = pi/180;

n = pose(1:3,1);
o = pose(1:3,2);
a = pose(1:3,3);
% 根据矩阵对应关系，反变换求th1
th1 = atan2(py-25*a(2),px-25*a(1))*ToDeg;
th5 = atan2(sin(th1)*n(1)-cos(th1)*n(2),cos(th1)*a(2)-sin(th1)*a(1))*ToDeg;
th2 = atan2(sin(th5)*n(3)-cos(th5)*a(3),sin(th5)*cos(th1)*n(1)+sin(th5)*sin(th1)*n(2)-cos(th5)*cos(th1)*a(1)-cos(th5)*sin(th1)*a(2))*ToDeg;

C2 = cos(th2);
C1 = cos(th1);
S1 = sin(th1);
S2 = sin(th2);
S5 = sin(th5);
C5 = cos(th5);
ax = a(1); ay = a(2); az = a(3);
nx = n(1); ny = n(2); nz = n(3);
ox = o(1); oy = o(2); oz = o(3);
th3 = atan2(-C2*(56 - pz + az*25) - 45.5*(C2*oz - S2*(C1*ox + S1*oy)) - 50*(C2*oz - S2*(C1*ox + S1*oy)) - S2*(C1*px + S1*py - 25*(C1*ax + S1*ay)),C2*(C1*px + S1*py - 25*(C1*ax + S1*ay)) - S2*(56 - pz + az*25) - C2^2*43 - S2^2*43 - 45.5*(S2*oz + C2*(C1*ox + S1*oy)) - 50*(S2*oz + C2*(C1*ox + S1*oy)))*ToDeg;
th34 = atan2(S5*(C2*az - S2*(C1*ax + S1*ay)) + C5*(C2*nz - S2*(C1*nx + S1*ny)),S5*(S2*az + C2*(C1*ax + S1*ay)) + C5*(S2*nz + C2*(C1*nx + S1*ny)))*ToDeg;
th4 = th34 - th3;

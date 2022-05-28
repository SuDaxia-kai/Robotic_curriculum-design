function [th1,th2,th3,th4,th5]=reverse_5(pose,px,py,pz)

ToDeg = 180/pi;
ToRad = pi/180;

n = pose(1:3,1);
o = pose(1:3,2);
a = pose(1:3,3);

ax = a(1); ay = a(2); az = a(3);
nx = n(1); ny = n(2); nz = n(3);
ox = o(1); oy = o(2); oz = o(3);

%% 根据矩阵 T2to6 对应关系，反变换求th1与th5
th1 = atan2(py,px);
th5 = atan2(sin(th1)*n(1)-cos(th1)*n(2),cos(th1)*a(2)-sin(th1)*a(1));

%% 根据 T2to5 对应关系，反变换求th234
C1 = cos(th1);
S1 = sin(th1);
S5 = sin(th5);
C5 = cos(th5);
th234 = atan2(C5*nz+S5*az,S5*(C1*ax+S1*ay)+C5*(C1*nx+S1*ny));

%% 根据 T2to6 对应关系，反变换求th3
t = pz - 50;
g = 50*sin(th234);
h = 50*cos(th234);


zanshi = ((C1*px+S1*py-g)^2+(t+h)^2-5000)/5000;
% th3 有多解
th3 = atan2(sqrt(1-zanshi^2),zanshi);
% th3 = -atan2(sqrt(1-zanshi^2),zanshi);

%% 再次从3中解方程，得th2
S3 = sin(th3);
C3 = cos(th3);

C2 = ((C1*px+S1*py-g)*(50*C3+50)+50*S3*(t+h))/((50*C3+50)^2 + (50*S3)^2);
S2 = ((t+h)*(50*C3+50)-50*S3*(C1*px+S1*py-g))/((50*C3+50)^2 + (50*S3)^2);
th2 = atan2(S2,C2);

%% 将角度进行转换，th4 = th234 - th2 - th3
th1 = round(th1 * ToDeg) + 180;
th2 = 90 - round(th2 * ToDeg);
th234 = 180 - round(th234 * ToDeg);
th3 = round(th3 * ToDeg);
th4 = th234 - th3 -th2;
th5 = round(th5 * ToDeg)+90;
end

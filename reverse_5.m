function [th1,th2,th3,th4,th5]=reverse_5(pose,px,py,pz)

ToDeg = 180/pi;
ToRad = pi/180;

n = pose(1:3,1);
o = pose(1:3,2);
a = pose(1:3,3);
t = pz - 50;


ax = a(1); ay = a(2); az = a(3);
nx = n(1); ny = n(2); nz = n(3);
ox = o(1); oy = o(2); oz = o(3);

% ���ݾ����Ӧ��ϵ�����任��th1
th1 = atan2(py,px);

th5 = atan2(sin(th1)*n(1)-cos(th1)*n(2),cos(th1)*a(2)-sin(th1)*a(1));

C1 = cos(th1);
S1 = sin(th1);
S5 = sin(th5);
C5 = cos(th5);
th234 = atan2(C5*nz+S5*az,S5*(C1*ax+S1*ay)+C5*(C1*nx+S1*ny));
g = 50*sin(th234);
h = 50*cos(th234);


zanshi = ((C1*px+S1*py-g)^2+(t+h)^2-5000)/5000;
th3 = atan2(sqrt(1-zanshi^2),zanshi);


S3 = sin(-th3);
C3 = cos(-th3);

C2 = ((C1*px+S1*py-g)*(50*C3+50)+50*S3*(t+h))/((50*C3+50)^2 + (50*S3)^2);
S2 = ((t+h)*(50*C3+50)-50*S3*(C1*px+S1*py-g))/((50*C3+50)^2 + (50*S3)^2);
th2 = atan2(S2,C2);




% th3 = atan2(50*(C1*S2*ox - C2*oz + S1*S2*oy) - C2*50 + C2*pz - C1*S2*px - S1*S2*py,S2*pz - S2*50 - C2^2*50 - S2^2*50 - 50*(S2*oz + C1*C2*ox + C2*S1*oy) + C1*C2*px + C2*S1*py);
% th34 = atan2(S5*(C1*S2*ax - C2*az + S1*S2*ay) + C5*(C1*S2*nx - C2*nz + S1*S2*ny),S5*(S2*az + C1*C2*ax + C2*S1*ay) + C5*(S2*nz + C1*C2*nx + C2*S1*ny));
% th3 = atan2(-C2*(56 - pz + az*25) - 45.5*(C2*oz - S2*(C1*ox + S1*oy)) - 50*(C2*oz - S2*(C1*ox + S1*oy)) - S2*(C1*px + S1*py - 25*(C1*ax + S1*ay)),C2*(C1*px + S1*py - 25*(C1*ax + S1*ay)) - S2*(56 - pz + az*25) - C2^2*43 - S2^2*43 - 45.5*(S2*oz + C2*(C1*ox + S1*oy)) - 50*(S2*oz + C2*(C1*ox + S1*oy)));
% th34 = atan2(S5*(C2*az - S2*(C1*ax + S1*ay)) + C5*(C2*nz - S2*(C1*nx + S1*ny)),S5*(S2*az + C2*(C1*ax + S1*ay)) + C5*(S2*nz + C2*(C1*nx + S1*ny)));
% th4 = th34 - th3;

th1 = round(th1 * ToDeg) + 180;
th2 = 90 - round(th2 * ToDeg);
th234 = 180 - round(th234 * ToDeg);
th3 = round(th3 * ToDeg);
th4 = th234 - th3 -th2;
th5 = round(th5 * ToDeg)+90;
% th34 = round(th34 * ToDeg);
end

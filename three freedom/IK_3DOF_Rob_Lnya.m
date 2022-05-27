function [th1,th2,th3]=IK_3DOF_Rob_Lnya(L1,L2,L3,px,py,pz)

ToDeg = 180/pi;
ToRad = pi/180;

% 根据矩阵对应关系，反变换求th1
th1=atan2(py,px);

P=[px,py,pz];
J2=[0,0,L1];

th3=pi-acos( ( L2^2+L3^2-norm(P-J2)^2)/(2*L2*L3) );
th3=-th3;    
C1=cos(th1);
S1=sin(th1);
C3=cos(th3);
S3=sin(th3);
A=C1*px + S1*py;
B=pz - L1;
W1=(L2+C3*L3);
W2=(L3*S3);
fprintf('W1^2+W2^2=%4.2f \n',W1^2+W2^2);
th2=atan2( (W1*B-W2*A),(W1*A+W2*B) );

fprintf('th1=%4.2f \n',th1*ToDeg);
fprintf('th2=%4.2f \n',th2*ToDeg);
fprintf('th3=%4.2f \n',th3*ToDeg);
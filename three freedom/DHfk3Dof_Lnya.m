function pic=DHfk3Dof_Lnya(th1,th2,th3,fcla)
% close all

global Link

Build_3DOFRobot_Lnya;
radius    = 10;
len       = 30;
joint_col = 0;


plot3(0,0,0,'ro'); 

% Link(2).th=th1*pi/180;
% Link(3).th=th2*pi/180;
% Link(4).th=th3*pi/180;
 
Link(2).th=Link(2).th+th1*pi/180;
Link(3).th=Link(3).th+th2*pi/180;
Link(4).th=Link(4).th+th3*pi/180;

p0=[0,0,0]';

for i=1:4
    Matrix_DH_Ln(i);
end

for i=2:4
      
      % 当前关节在世界坐标系下的表示
      Link(i).A=Link(i-1).A*Link(i).A;   
      Link(i).p= Link(i).A(:,4);
      Link(i).n= Link(i).A(:,1);
      Link(i).o= Link(i).A(:,2);
      Link(i).a= Link(i).A(:,3);
      Link(i).R=[Link(i).n(1:3),Link(i).o(1:3),Link(i).a(1:3)];
      Connect3D(Link(i-1).p,Link(i).p,'b',2); hold on;
      DrawCylinder(Link(i-1).p, Link(i-1).R * Link(i).az, radius,len, joint_col); hold on;
end


grid on;
view(134,12);
axis([-200,200,-200,200,-200,300]);
xlabel('x');
ylabel('y');
zlabel('z');
drawnow;
pic=getframe;
if(fcla)
    cla;
end



function pic=MDHfk3Dof_Lnya(th1,th2,th3,th4,th5,fcla)
% close all

global Link

Build_MDH_Lnya;
radius    = 10;
len       = 30;
joint_col = 0;


% plot3(0,0,0,'ro'); 

%  Link(2).th=th1*pi/180;
%  Link(3).th=th2*pi/180;
%  Link(4).th=th3*pi/180;
%  Link(5).th=th4*pi/180;
 
 Link(2).th=Link(2).th+th1*pi/180;
 Link(3).th=Link(3).th+th2*pi/180;
 Link(4).th=Link(4).th+th3*pi/180;
 Link(5).th=Link(5).th+th4*pi/180;
 Link(7).th=Link(7).th+th5*pi/180;


for i=1:8
    Matrix_MDH_Ln(i);
end

for i=2:8
      Link(i).A=Link(i-1).A*Link(i).A;
      Link(i).p= Link(i).A(:,4);
      Link(i).n= Link(i).A(:,1);
      Link(i).o= Link(i).A(:,2);
      Link(i).a= Link(i).A(:,3);
      Link(i).R=[Link(i).n(1:3),Link(i).o(1:3),Link(i).a(1:3)];
      if i == 6
        Connect3D(Link(i-1).p,Link(i).p,'b',2); hold on;
        DrawCylinder(Link(i).p, Link(i).R * Link(i).az, radius,len, joint_col); hold on;
      elseif i == 7
        Connect3D(Link(i-1).p,Link(i).p,'b',2); hold on;
      else
        Connect3D(Link(i-1).p,Link(i).p,'b',2); hold on;
        DrawCylinder(Link(i-1).p, Link(i-1).R * Link(i).az, radius,len, joint_col); hold on;
      end
end

plot3(-24.9049,-2.1789,237.5,'r*');
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



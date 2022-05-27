close all;
clear;

motorCom=10;  %设置串口编号，请检查设备管理器确认
Mcom=Com_On(motorCom); %开串口，Mcom为串口结构体，波特率默认9600
fprintf('Com %d Open \n', motorCom);   %打印显示串口打开成功，如果失败程序将会一直开在这里

ToDeg = 180/pi;
ToRad = pi/180;
%需要改，对应实际机械臂
L1=50;
L2=100; 
L3=100;

th=[0,0,0,90,90,90]';   %数组

DHfk3Dof_Lnya(th(1),th(2),th(3),0); 
plot3(200*sin(pi/6),200*cos(pi/6),50,'r*');
view(134,12);
pause;
stp=5;   %关节步进值
spd=10; %电机速度（最大为10）
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Joint1
[expect1,expect2,expect3] = IK_3DOF_Rob_Lnya(L1,L2,L3,200*sin(pi/6),200*cos(pi/6),50);
expect = [expect1,expect2,expect3];
expect = expect.*ToDeg;

for i=0:5*expect(1)/abs(expect(1)):int32(expect(1))
    th(1)=i;
    DHfk3Dof_Lnya(th(1),th(2),th(3),1);
%     jnt=Sj2Rj(th);   % 把仿真的角度转换成实际关节角
%     for n = 1:1:6
%         sendbuf =  JointCmd(n, spd,jnt(n));% 生成对应关节的控制指令（编号，速度（1-20），目标角度）
%         fwrite(Mcom,sendbuf,'uint8');%向串口发送关节控制指令
%     end
end
pause(0.2);

for i=0:5*expect(2)/abs(expect(2)):expect(2)
    th(2)=i;
    DHfk3Dof_Lnya(th(1),th(2),th(3),1);
%     jnt=Sj2Rj(th);   % 把仿真的角度转换成实际关节角
%     for n = 1:1:6
%         sendbuf =  JointCmd(n, spd,jnt(n));% 生成对应关节的控制指令（编号，速度（1-20），目标角度）
%         fwrite(Mcom,sendbuf,'uint8');%向串口发送关节控制指令
%     end
end
pause(0.2);

for i=0:5*expect(3)/abs(expect(3)):expect(3)
    th(3)=i;
    DHfk3Dof_Lnya(th(1),th(2),th(3),1);
%     jnt=Sj2Rj(th);   % 把仿真的角度转换成实际关节角
%     for n = 1:1:6
%         sendbuf =  JointCmd(n, spd,jnt(n));% 生成对应关节的控制指令（编号，速度（1-20），目标角度）
%         fwrite(Mcom,sendbuf,'uint8');%向串口发送关节控制指令
%     end
end
pause(0.2);

%关闭串口
Com_Off(Mcom);  %重要，必须和Com_On一起配套使用，否者下次申请打开串口将会提示占用


close all;
clear;

motorCom=4;  %设置串口编号，请检查设备管理器确认
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
view(134,12);
pause;
stp=5;   %关节步进值
spd=10; %电机速度（最大为10）
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Joint1
for i=0:stp:180
    th(1)=i;
    DHfk3Dof_Lnya(th(1),th(2),th(3),1);
    jnt=Sj2Rj(th);   % 把仿真的角度转换成实际关节角
    for n = 1:1:6
        sendbuf =  JointCmd(n, spd,jnt(n));% 生成对应关节的控制指令（编号，速度（1-20），目标角度）
        fwrite(Mcom,sendbuf,'uint8');%向串口发送关节控制指令
    end
end


for i=180:-stp:0
    if i==0
        DHfk3Dof_Lnya(i,th(2),th(3),0); 
    else
        th(1)=i;
        DHfk3Dof_Lnya(th(1),th(2),th(3),1);
        jnt=Sj2Rj(th);
        for n = 1:1:6
            sendbuf =  JointCmd(n, spd,jnt(n));% 生成对应关节的控制指令（编号，速度（1-20），目标角度）
            fwrite(Mcom,sendbuf,'uint8');%向串口发送关节控制指令
        end
    end
end
pause(0.2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Joint2


for i=0:stp:180
    th(2)=i;
    DHfk3Dof_Lnya(th(1),th(2),th(3),1);
    jnt=Sj2Rj(th);
    for n = 1:1:6
        sendbuf =  JointCmd(n, spd,jnt(n));% 生成对应关节的控制指令（编号，速度（1-20），目标角度）
        fwrite(Mcom,sendbuf,'uint8');%向串口发送关节控制指令
    end
end

for i=180:-stp:0
    if i==0
        th(2)=i;
        DHfk3Dof_Lnya(th(1),th(2),th(3),1);
    else
        th(2)=i;
        DHfk3Dof_Lnya(th(1),th(2),th(3),1);
        jnt=Sj2Rj(th);
        for n = 1:1:6
            sendbuf =  JointCmd(n, spd,jnt(n));% 生成对应关节的控制指令（编号，速度（1-20），目标角度）
            fwrite(Mcom,sendbuf,'uint8');%向串口发送关节控制指令
        end
    end
end
pause(0.2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Joint3

for i=0:-stp:-90
    th(3)=i;
     DHfk3Dof_Lnya(th(1),th(2),th(3),1);
    jnt=Sj2Rj(th);
    for n = 1:1:6
        sendbuf =  JointCmd(n, spd,jnt(n));% 生成对应关节的控制指令（编号，速度（1-20），目标角度）
        fwrite(Mcom,sendbuf,'uint8');%向串口发送关节控制指令
    end
end
pause(0.1);

for i=-90:stp:90
    if i==90
        th(3)=i;
         DHfk3Dof_Lnya(th(1),th(2),th(3),0);
    else
        th(3)=i;
         DHfk3Dof_Lnya(th(1),th(2),th(3),1);
        jnt=Sj2Rj(th);
        for n = 1:1:6
            sendbuf =  JointCmd(n, spd,jnt(n));% 生成对应关节的控制指令（编号，速度（1-20），目标角度）
            fwrite(Mcom,sendbuf,'uint8');%向串口发送关节控制指令
        end
    end
end
pause(2);
%关闭串口
Com_Off(Mcom);  %重要，必须和Com_On一起配套使用，否者下次申请打开串口将会提示占用


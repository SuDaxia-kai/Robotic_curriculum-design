close all;
clear;

motorCom=4;  %设置串口编号，请检查设备管理器确认
Mcom=Com_On(motorCom); %开串口，Mcom为串口结构体，波特率默认9600
fprintf('Com %d Open \n', motorCom);   %打印显示串口打开成功，如果失败程序将会一直开在这里

ToDeg = 180/pi;
ToRad = pi/180;

%运动轨迹起点
p=[0 0 200];

%需要改，对应实际机械臂的关节长度
L1=50;
L2=100; 
L3=100;
global Link

view(134,12);

pause;
stp=5;   %关节步进值
spd=10; %电机速度（最大为10）

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%求逆并设计运动
for x=10:stp:130
    p(1)=x;
    %输入坐标进行逆运动求解，返回三个关节角
    [expect1,expect2,expect3] = IK_3DOF_Rob_Lnya(L1,L2,L3,p(1),p(2),p(3));
    expect = [expect1,expect2,expect3,pi/2,pi/2,pi/2];
    expect = round(expect.*ToDeg);
    if x==10
        DHfk3Dof_Lnya(expect(1),expect(2),expect(3),0);
        plot3([10,p(1)],[p(2),p(2)],[p(3),p(3)],'r-');
    else
        pause(1)
        DHfk3Dof_Lnya(expect(1),expect(2),expect(3),1);
        DHfk3Dof_Lnya(expect(1),expect(2),expect(3),0);
        plot3([10,p(1)],[p(2),p(2)],[p(3),p(3)],'r-');
    end
    jnt=Sj2Rj(expect);   % 把仿真的角度转换成实际关节角
    for n = 1:1:6
        sendbuf =  JointCmd(n, spd,jnt(n));% 生成对应关节的控制指令（编号，速度（1-20），目标角度）
        fwrite(Mcom,sendbuf,'uint8');%向串口发送关节控制指令
    end
end

%关闭串口
Com_Off(Mcom);  %重要，必须和Com_On一起配套使用，否者下次申请打开串口将会提示占用


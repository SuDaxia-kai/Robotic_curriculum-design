% 利用人眼识别的高级功能对机械臂进行校准
clear;
clc;
spd=5;% 电机速度，最大值为20
motorCom=4;  %设置串口编号，请检查设备管理器确认
Mcom=Com_On(motorCom); %开串口，Mcom为串口结构体，波特率默认9600
fprintf('Com %d Open \n', motorCom);   %打印显示串口打开成功，如果失败程序将会一直开在这里

th = [90 97 90 85 85 90];
for i = 1:6
    sendbuf =  JointCmd(i, spd, th(i));% 生成对应关节的控制指令（编号，速度（1-20），目标角度）
    fwrite(Mcom,sendbuf,'uint8');%向串口发送关节控制指令
end


%% 关闭串口,打开关闭必须要配对使用
Com_Off(Mcom);  %重要，必须和Com_On一起配套使用，否者下次申请打开串口将会提示占用
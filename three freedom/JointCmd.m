%使用说明%
%函数作用，生成对应关节号的控制数据序列，
%生成后需要配合fwrite（对应2019以前的版本）或者是write（对应2019以后的版本）函数进行串口发送才能使电机动作
%输入变量（通道号，速度，期望角度）
%速度取值范围 1到20，建议取5，电机速度不要转太快。
%角度取值：对于TS90A舵机，最大转动角度范围为0°-180°
%%%%%%%%%%lnya 2022-04-14%%%%%%%%%%

function  sendbuf =JointCmd(channel, speed, angle)

sendbuf = zeros(10,1);
sendbuf(1,1) = uint8(hex2dec('ff'));
sendbuf(2,1) = uint8(hex2dec('01'));
sendbuf(3,1) = uint8(channel);
sendbuf(4,1) = uint8(speed);
sendbuf(5,1) = uint8(hex2dec('00'));
sendbuf(6,1) = uint8(hex2dec('ff'));
sendbuf(7,1) = uint8(hex2dec('02'));
sendbuf(8,1) = uint8(channel);
angle = fix(500 + (angle/180)*2000);
angle_h = fix(angle/256)
angle_l = bitand(angle, 255)
sendbuf(9,1) = uint8(angle_l);
sendbuf(10,1)= uint8(angle_h);

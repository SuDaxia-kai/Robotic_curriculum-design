%ʹ��˵��%
%�������ã����ɶ�Ӧ�ؽںŵĿ����������У�
%���ɺ���Ҫ���fwrite����Ӧ2019��ǰ�İ汾��������write����Ӧ2019�Ժ�İ汾���������д��ڷ��Ͳ���ʹ�������
%���������ͨ���ţ��ٶȣ������Ƕȣ�
%�ٶ�ȡֵ��Χ 1��20������ȡ5������ٶȲ�Ҫת̫�졣
%�Ƕ�ȡֵ������TS90A��������ת���Ƕȷ�ΧΪ0��-180��
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

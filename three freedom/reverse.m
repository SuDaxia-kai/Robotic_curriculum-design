close all;
clear;

motorCom=10;  %���ô��ڱ�ţ������豸������ȷ��
Mcom=Com_On(motorCom); %�����ڣ�McomΪ���ڽṹ�壬������Ĭ��9600
fprintf('Com %d Open \n', motorCom);   %��ӡ��ʾ���ڴ򿪳ɹ������ʧ�ܳ��򽫻�һֱ��������

ToDeg = 180/pi;
ToRad = pi/180;
%��Ҫ�ģ���Ӧʵ�ʻ�е��
L1=50;
L2=100; 
L3=100;

th=[0,0,0,90,90,90]';   %����

DHfk3Dof_Lnya(th(1),th(2),th(3),0); 
plot3(200*sin(pi/6),200*cos(pi/6),50,'r*');
view(134,12);
pause;
stp=5;   %�ؽڲ���ֵ
spd=10; %����ٶȣ����Ϊ10��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Joint1
[expect1,expect2,expect3] = IK_3DOF_Rob_Lnya(L1,L2,L3,200*sin(pi/6),200*cos(pi/6),50);
expect = [expect1,expect2,expect3];
expect = expect.*ToDeg;

for i=0:5*expect(1)/abs(expect(1)):int32(expect(1))
    th(1)=i;
    DHfk3Dof_Lnya(th(1),th(2),th(3),1);
%     jnt=Sj2Rj(th);   % �ѷ���ĽǶ�ת����ʵ�ʹؽڽ�
%     for n = 1:1:6
%         sendbuf =  JointCmd(n, spd,jnt(n));% ���ɶ�Ӧ�ؽڵĿ���ָ���ţ��ٶȣ�1-20����Ŀ��Ƕȣ�
%         fwrite(Mcom,sendbuf,'uint8');%�򴮿ڷ��͹ؽڿ���ָ��
%     end
end
pause(0.2);

for i=0:5*expect(2)/abs(expect(2)):expect(2)
    th(2)=i;
    DHfk3Dof_Lnya(th(1),th(2),th(3),1);
%     jnt=Sj2Rj(th);   % �ѷ���ĽǶ�ת����ʵ�ʹؽڽ�
%     for n = 1:1:6
%         sendbuf =  JointCmd(n, spd,jnt(n));% ���ɶ�Ӧ�ؽڵĿ���ָ���ţ��ٶȣ�1-20����Ŀ��Ƕȣ�
%         fwrite(Mcom,sendbuf,'uint8');%�򴮿ڷ��͹ؽڿ���ָ��
%     end
end
pause(0.2);

for i=0:5*expect(3)/abs(expect(3)):expect(3)
    th(3)=i;
    DHfk3Dof_Lnya(th(1),th(2),th(3),1);
%     jnt=Sj2Rj(th);   % �ѷ���ĽǶ�ת����ʵ�ʹؽڽ�
%     for n = 1:1:6
%         sendbuf =  JointCmd(n, spd,jnt(n));% ���ɶ�Ӧ�ؽڵĿ���ָ���ţ��ٶȣ�1-20����Ŀ��Ƕȣ�
%         fwrite(Mcom,sendbuf,'uint8');%�򴮿ڷ��͹ؽڿ���ָ��
%     end
end
pause(0.2);

%�رմ���
Com_Off(Mcom);  %��Ҫ�������Com_Onһ������ʹ�ã������´�����򿪴��ڽ�����ʾռ��

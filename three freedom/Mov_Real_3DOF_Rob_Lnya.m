close all;
clear;

motorCom=4;  %���ô��ڱ�ţ������豸������ȷ��
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
view(134,12);
pause;
stp=5;   %�ؽڲ���ֵ
spd=10; %����ٶȣ����Ϊ10��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Joint1
for i=0:stp:180
    th(1)=i;
    DHfk3Dof_Lnya(th(1),th(2),th(3),1);
    jnt=Sj2Rj(th);   % �ѷ���ĽǶ�ת����ʵ�ʹؽڽ�
    for n = 1:1:6
        sendbuf =  JointCmd(n, spd,jnt(n));% ���ɶ�Ӧ�ؽڵĿ���ָ���ţ��ٶȣ�1-20����Ŀ��Ƕȣ�
        fwrite(Mcom,sendbuf,'uint8');%�򴮿ڷ��͹ؽڿ���ָ��
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
            sendbuf =  JointCmd(n, spd,jnt(n));% ���ɶ�Ӧ�ؽڵĿ���ָ���ţ��ٶȣ�1-20����Ŀ��Ƕȣ�
            fwrite(Mcom,sendbuf,'uint8');%�򴮿ڷ��͹ؽڿ���ָ��
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
        sendbuf =  JointCmd(n, spd,jnt(n));% ���ɶ�Ӧ�ؽڵĿ���ָ���ţ��ٶȣ�1-20����Ŀ��Ƕȣ�
        fwrite(Mcom,sendbuf,'uint8');%�򴮿ڷ��͹ؽڿ���ָ��
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
            sendbuf =  JointCmd(n, spd,jnt(n));% ���ɶ�Ӧ�ؽڵĿ���ָ���ţ��ٶȣ�1-20����Ŀ��Ƕȣ�
            fwrite(Mcom,sendbuf,'uint8');%�򴮿ڷ��͹ؽڿ���ָ��
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
        sendbuf =  JointCmd(n, spd,jnt(n));% ���ɶ�Ӧ�ؽڵĿ���ָ���ţ��ٶȣ�1-20����Ŀ��Ƕȣ�
        fwrite(Mcom,sendbuf,'uint8');%�򴮿ڷ��͹ؽڿ���ָ��
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
            sendbuf =  JointCmd(n, spd,jnt(n));% ���ɶ�Ӧ�ؽڵĿ���ָ���ţ��ٶȣ�1-20����Ŀ��Ƕȣ�
            fwrite(Mcom,sendbuf,'uint8');%�򴮿ڷ��͹ؽڿ���ָ��
        end
    end
end
pause(2);
%�رմ���
Com_Off(Mcom);  %��Ҫ�������Com_Onһ������ʹ�ã������´�����򿪴��ڽ�����ʾռ��


close all;
clear;

motorCom=4;  %���ô��ڱ�ţ������豸������ȷ��
Mcom=Com_On(motorCom); %�����ڣ�McomΪ���ڽṹ�壬������Ĭ��9600
fprintf('Com %d Open \n', motorCom);   %��ӡ��ʾ���ڴ򿪳ɹ������ʧ�ܳ��򽫻�һֱ��������

ToDeg = 180/pi;
ToRad = pi/180;

%�˶��켣���
p=[0 0 200];

%��Ҫ�ģ���Ӧʵ�ʻ�е�۵Ĺؽڳ���
L1=50;
L2=100; 
L3=100;
global Link

view(134,12);

pause;
stp=5;   %�ؽڲ���ֵ
spd=10; %����ٶȣ����Ϊ10��

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%���沢����˶�
for x=10:stp:130
    p(1)=x;
    %��������������˶���⣬���������ؽڽ�
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
    jnt=Sj2Rj(expect);   % �ѷ���ĽǶ�ת����ʵ�ʹؽڽ�
    for n = 1:1:6
        sendbuf =  JointCmd(n, spd,jnt(n));% ���ɶ�Ӧ�ؽڵĿ���ָ���ţ��ٶȣ�1-20����Ŀ��Ƕȣ�
        fwrite(Mcom,sendbuf,'uint8');%�򴮿ڷ��͹ؽڿ���ָ��
    end
end

%�رմ���
Com_Off(Mcom);  %��Ҫ�������Com_Onһ������ʹ�ã������´�����򿪴��ڽ�����ʾռ��


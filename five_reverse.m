close all;
clear;

% motorCom=5;  %���ô��ڱ�ţ������豸������ȷ��
% Mcom=Com_On(motorCom); %�����ڣ�McomΪ���ڽṹ�壬������Ĭ��9600
% fprintf('Com %d Open \n', motorCom);   %��ӡ��ʾ���ڴ򿪳ɹ������ʧ�ܳ��򽫻�һֱ��������

ToDeg = 180/pi;
ToRad = pi/180;
%��Ҫ�ģ���Ӧʵ�ʻ�е��
L1=50;
L2=100;
L3=100;
L4=100;
L5=50;

th=[0,0,0,0,0,0]';   %����
solution = [35,-75, 45,-60,40,0;
            35,-30,-45,-15,40,0;
            ]; % �����е�۵���������

MDHfk3Dof_Lnya(th(1),th(2),th(3),th(4),th(5),0); 
% final_A = Link(8).A;
% 
% pose = final_A(1:3,1:3);
% px = final_A(1,4);
% py = final_A(2,4);
% pz = final_A(3,4);
% [t1,t2,t3,t4,t5] = reverse_5(pose,px,py,pz)

view(134,12);
pause;
stp=5;   %�ؽڲ���ֵ
spd=10; %����ٶȣ����Ϊ10��

i_1 = 0; i_2 = 0; i_3 = 0; i_4 = 0; i_5 = 0;
for times = 1:1:2
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Joint1
    if solution(times,1)-i_1 == 0
        realstp = 0;
    else
        realstp = (stp*((solution(times,1)-i_1)/abs(solution(times,1)-i_1)));
    end
    for i_1 = i_1: realstp :solution(times,1)
        th(1) = i_1;
        MDHfk3Dof_Lnya(i_1,th(2),th(3),th(4),th(5),1); 
    %     jnt=Sj2Rj(th);   % �ѷ���ĽǶ�ת����ʵ�ʹؽڽ�
    %     for n = 1:1:6
    %         sendbuf =  JointCmd(n, spd,jnt(n));% ���ɶ�Ӧ�ؽڵĿ���ָ���ţ��ٶȣ�1-20����Ŀ��Ƕȣ�
    %         fwrite(Mcom,sendbuf,'uint8');%�򴮿ڷ��͹ؽڿ���ָ��
    %     end
    end
    pause(0.2);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Joint2
    realstp = (stp*((solution(times,2)-i_2)/abs(solution(times,2)-i_2)));
    for i_2 = i_2:realstp:solution(times,2)
        if i_2 == solution(times,2)
            th(2) = i_2;
            MDHfk3Dof_Lnya(th(1),i_2,th(3),th(4),th(5),0); 
        else
            th(2)=i_2;
            MDHfk3Dof_Lnya(th(1),th(2),th(3),th(4),th(5),1); 
    %         jnt=Sj2Rj(th);
    %         for n = 1:1:6
    %             sendbuf =  JointCmd(n, spd,jnt(n));% ���ɶ�Ӧ�ؽڵĿ���ָ���ţ��ٶȣ�1-20����Ŀ��Ƕȣ�
    %             fwrite(Mcom,sendbuf,'uint8');%�򴮿ڷ��͹ؽڿ���ָ��
    %         end
        end
    end
    pause(0.2);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Joint3
    realstp = (stp*((solution(times,3)-i_3)/abs(solution(times,3)-i_3)));
    for i_3 = i_3:realstp:solution(times,3)
        if i_3 == solution(times,3)
            th(3) = i_3;
            MDHfk3Dof_Lnya(th(1),th(2),i_3,th(4),th(5),0); 
        else
            th(3) = i_3;
            MDHfk3Dof_Lnya(th(1),th(2),th(3),th(4),th(5),1); 
    %         jnt=Sj2Rj(th);
    %         for n = 1:1:6
    %             sendbuf =  JointCmd(n, spd,jnt(n));% ���ɶ�Ӧ�ؽڵĿ���ָ���ţ��ٶȣ�1-20����Ŀ��Ƕȣ�
    %             fwrite(Mcom,sendbuf,'uint8');%�򴮿ڷ��͹ؽڿ���ָ��
    %         end
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Joint4
    realstp = (stp*((solution(times,4)-i_4)/abs(solution(times,4)-i_4)));
    for i_4 = i_4:realstp:solution(times,4)
        if i_4 == solution(times,4)
            th(4)=i_4;
            MDHfk3Dof_Lnya(th(1),th(2),th(3),i_4,th(5),0); 
        else
            th(4)=i_4;
            MDHfk3Dof_Lnya(th(1),th(2),th(3),th(4),th(5),1); 
    %         jnt=Sj2Rj(th);
    %         for n = 1:1:6
    %             sendbuf =  JointCmd(n, spd,jnt(n));% ���ɶ�Ӧ�ؽڵĿ���ָ���ţ��ٶȣ�1-20����Ŀ��Ƕȣ�
    %             fwrite(Mcom,sendbuf,'uint8');%�򴮿ڷ��͹ؽڿ���ָ��
    %         end
        end
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Joint5
    if solution(times,5)-i_5 == 0
        realstp = 0;
    else
        realstp = (stp*((solution(times,5)-i_5)/abs(solution(times,5)-i_5)));
    end
    for i_5 = i_5:realstp:solution(times,5)
        if i_5 == solution(times,5)
            th(5)=i_5;
            MDHfk3Dof_Lnya(th(1),th(2),th(3),th(4),i_5,0); 
        else
            th(5)=i_5;
            MDHfk3Dof_Lnya(th(1),th(2),th(3),th(4),th(5),1); 
    %         jnt=Sj2Rj(th);
    %         for n = 1:1:6
    %             sendbuf =  JointCmd(n, spd,jnt(n));% ���ɶ�Ӧ�ؽڵĿ���ָ���ţ��ٶȣ�1-20����Ŀ��Ƕȣ�
    %             fwrite(Mcom,sendbuf,'uint8');%�򴮿ڷ��͹ؽڿ���ָ��
    %         end
        end
    end
end

pause(2);
%�رմ���
% Com_Off(Mcom);  %��Ҫ�������Com_Onһ������ʹ�ã������´�����򿪴��ڽ�����ʾռ��
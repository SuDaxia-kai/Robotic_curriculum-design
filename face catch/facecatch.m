clear;
clc;
%% ���ô���
motorCom=5;  %���ô��ڱ�ţ������豸������ȷ��
Mcom=Com_On(motorCom); %�����ڣ�McomΪ���ڽṹ�壬������Ĭ��9600
fprintf('Com %d Open \n', motorCom);   %��ӡ��ʾ���ڴ򿪳ɹ������ʧ�ܳ��򽫻�һֱ��������

%% ��׽����
ToDeg = 180/pi;
ToRad = pi/180;
faceDetector = vision.CascadeObjectDetector(); % ����MatLab�е�VJ�㷨
bbox = [100 100 100 100];

vidDevice = imaq.VideoDevice('winvideo', 1, 'YUY2_640x480', ...
    'ROI', [1 1 640 480], ...
    'ReturnedColorSpace', 'rgb' );

boxInserter = vision.ShapeInserter('BorderColor','Custom',...
    'CustomBorderColor',[255 255 0]);
textInserter = vision.TextInserter('%d','LocationSource','Input port','Color',[255,255, 0],'FontSize',12);

Frame =3000;   % ����ִ��֡��Ϊ300֡
vidInfo = imaqhwinfo(vidDevice);
vidHeight = vidInfo.MaxHeight;
vidWidth = vidInfo.MaxWidth;
videoPlayer = vision.VideoPlayer('Position',[300 100 640+30 480+30]);

%% ��ʼ������ͷ��ͼ����в���
MDHfk3Dof_Lnya(0,0,-90,0,0,0); 
pause;
for k = 1:Frame 
    videoFrame = step(vidDevice); % ��ʾ��������ͷ�ĵ�ͼ��
    bbox = 4 * faceDetector.step(imresize(videoFrame, 1/4)) 
    videoOut = step(boxInserter, videoFrame, bbox);
    %release(boxInserter);
    step(videoPlayer, videoOut);
    s_temp_size = size(bbox);
    % ��ʼ��������
    if  s_temp_size ~= [0,0]
        centre = [320,240];
        face_centre = [(bbox(1)+bbox(3))*0.5,(bbox(2)+bbox(4))];
        th1 = (face_centre(1)-320)*90/320;
        th3 = -(face_centre(2)-240)*90/240 - 60;
        MDHfk3Dof_Lnya(th1,0,th3,0,0,1); 
        th = [th1,0,th3,0,0,0];
        jnt=Sj2Rj(th);
        for n = 1:1:6
            sendbuf = JointCmd(n, spd,jnt(n));% ���ɶ�Ӧ�ؽڵĿ���ָ���ţ��ٶȣ�1-20����Ŀ��Ƕȣ�
            fwrite(Mcom,sendbuf,'uint8');%�򴮿ڷ��͹ؽڿ���ָ��
        end
    end
end

Com_Off(Mcom);  %��Ҫ�������Com_Onһ������ʹ�ã������´�����򿪴��ڽ�����ʾռ��

clear;
clc;
%% 设置串口
motorCom=5;  %设置串口编号，请检查设备管理器确认
Mcom=Com_On(motorCom); %开串口，Mcom为串口结构体，波特率默认9600
fprintf('Com %d Open \n', motorCom);   %打印显示串口打开成功，如果失败程序将会一直开在这里

%% 捕捉人脸
ToDeg = 180/pi;
ToRad = pi/180;
faceDetector = vision.CascadeObjectDetector(); % 调用MatLab中的VJ算法
bbox = [100 100 100 100];

vidDevice = imaq.VideoDevice('winvideo', 1, 'YUY2_640x480', ...
    'ROI', [1 1 640 480], ...
    'ReturnedColorSpace', 'rgb' );

boxInserter = vision.ShapeInserter('BorderColor','Custom',...
    'CustomBorderColor',[255 255 0]);
textInserter = vision.TextInserter('%d','LocationSource','Input port','Color',[255,255, 0],'FontSize',12);

Frame =3000;   % 设置执行帧数为300帧
vidInfo = imaqhwinfo(vidDevice);
vidHeight = vidInfo.MaxHeight;
vidWidth = vidInfo.MaxWidth;
videoPlayer = vision.VideoPlayer('Position',[300 100 640+30 480+30]);

%% 开始对摄像头的图像进行操作
MDHfk3Dof_Lnya(0,0,-90,0,0,0); 
pause;
for k = 1:Frame 
    videoFrame = step(vidDevice); % 显示我们摄像头拍的图像
    bbox = 4 * faceDetector.step(imresize(videoFrame, 1/4)) 
    videoOut = step(boxInserter, videoFrame, bbox);
    %release(boxInserter);
    step(videoPlayer, videoOut);
    s_temp_size = size(bbox);
    % 开始跟踪人脸
    if  s_temp_size ~= [0,0]
        centre = [320,240];
        face_centre = [(bbox(1)+bbox(3))*0.5,(bbox(2)+bbox(4))];
        th1 = (face_centre(1)-320)*90/320;
        th3 = -(face_centre(2)-240)*90/240 - 60;
        MDHfk3Dof_Lnya(th1,0,th3,0,0,1); 
        th = [th1,0,th3,0,0,0];
        jnt=Sj2Rj(th);
        for n = 1:1:6
            sendbuf = JointCmd(n, spd,jnt(n));% 生成对应关节的控制指令（编号，速度（1-20），目标角度）
            fwrite(Mcom,sendbuf,'uint8');%向串口发送关节控制指令
        end
    end
end

Com_Off(Mcom);  %重要，必须和Com_On一起配套使用，否者下次申请打开串口将会提示占用

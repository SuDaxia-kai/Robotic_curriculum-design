clear;
clc;
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
for k = 1:Frame 
    videoFrame = step(vidDevice); % 显示我们摄像头拍的图像
    bbox = 4 * faceDetector.step(imresize(videoFrame, 1/4)) 
    videoOut = step(boxInserter, videoFrame, bbox);
    %release(boxInserter);
    step(videoPlayer, videoOut); 
end
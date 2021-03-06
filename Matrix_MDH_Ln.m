%% 附加说明
% Matrix_DH_Ln 生成了 DH 参数表的齐次变换矩阵A，位姿矩阵R

function Matrix_MDH_Ln(i)
% Caculate the D-H Matrix
global Link

ToDeg = 180/pi;
ToRad = pi/180;


C=cos(Link(i).th);
S=sin(Link(i).th);
Ca=cos(Link(i).alf);
Sa=sin(Link(i).alf);
a=Link(i).dx;    %distance between zi and zi-1
d=Link(i).dz;    %distance between xi and xi-1

Link(i).n=[C,S,0,0]';
Link(i).o=[-1*S*Ca,C*Ca,Sa,0]';
Link(i).a=[S*Sa, -1*C*Sa,Ca,0]';
Link(i).p=[a*C,a*S,d,1]';

% 保存姿态矩阵
Link(i).R=[Link(i).n(1:3),Link(i).o(1:3),Link(i).a(1:3)];
% 保存转换过后的姿态与位置
Link(i).A=[Link(i).n,Link(i).o,Link(i).a,Link(i).p];


%%%%%%%%%%%%%%%%%%%%%%%%开电机串口%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%Lnya,2017.03.19%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function g=Com_On(cNum)

comNum=sprintf('com%d',cNum);
g=serial(comNum);
set(g,'BaudRate',9600);
fopen(g);


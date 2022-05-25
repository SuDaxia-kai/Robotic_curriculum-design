% %Build Robot by D_H methods


ToDeg = 180/pi;
ToRad = pi/180;
UX = [1 0 0]';
UY = [0 1 0]';
UZ = [0 0 1]';

Link    = struct('name','Body' , 'alf',0*ToRad, 'dx', 0, 'th', 0, 'dz',0,'az',UZ);     % az 
Link(1) = struct('name','Base' ,  'alf',0*ToRad, 'dx', 0, 'th', 0*ToRad, 'dz',0,'az',UZ);        %Base To 1
Link(2) = struct('name','J1' , 'alf', 0*ToRad, 'dx', 0, 'th', -180*ToRad, 'dz',50,'az',UZ);       %1 TO 1.5
Link(3) = struct('name','J2' , 'alf', 90*ToRad, 'dx', 0, 'th', 0*ToRad, 'dz',0,'az',UZ);    %1.5 TO 2
Link(4) = struct('name','J3' , 'alf',  0*ToRad, 'dx', 0, 'th', 90*ToRad, 'dz',0,'az',UZ);          %2 TO 2.5
Link(5) = struct('name','J3' , 'alf',  0*ToRad, 'dx', 100, 'th', 0*ToRad, 'dz',0,'az',UZ);          %2.5 TO 3
Link(6) = struct('name','J3' , 'alf',  0*ToRad, 'dx', 100, 'th', 0*ToRad, 'dz',0,'az',UZ);          %3 TO 4
Link(7) = struct('name','J3' , 'alf',  0*ToRad, 'dx', 0, 'th', 90*ToRad, 'dz',0,'az',UZ);          %4 TO 4.5
Link(8) = struct('name','J3' , 'alf',  90*ToRad, 'dx', 0, 'th', 0*ToRad, 'dz',50,'az',UZ);          %4.5 TO 5
Link(9) = struct('name','J3' , 'alf',  0*ToRad, 'dx', 0, 'th', 90*ToRad, 'dz',0,'az',UZ);          %5 TO 5.5
Link(10) = struct('name','J3' , 'alf',  90*ToRad, 'dx', 0, 'th', 90*ToRad, 'dz',0,'az',UZ);          %5.5 TO зІзг
Link(11) = struct('name','J3' , 'alf',  0*ToRad, 'dx', 0, 'th', 0*ToRad, 'dz',0,'az',UZ);          %зІзг TO End

% 
%       Link1             Link2
% % -------------[     ]------(O)
% %                            |
% %                            |
% %                            []
% %                            |
% %                            |
                           
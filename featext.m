
function [X,y]=featext(num)
% To filter the signal

C3F=filter(Hbp,C3);
C4F=filter(Hbp,C4);
clear C3 C4
C3=C3F; C4=C4F;
clear C3F C4F

% Feature Extraction
% 1. Welch's Power Spectral Density
N=size(C3);
for i=1:N(1)
PC3(i,:)=pyulear(C3(i,:),10,[8:30],250);
PC4(i,:)=pyulear(C4(i,:),10,[8:30],250);
end
X=horzcat(PC3,PC4);

% Class Formation
for i=1:2:60
    y(i,:)=1;
    y(i+1,:)=2;
end

y(1:20,2)=100;
y(21:40,2)=200;
y(41:60,2)=300;
centrex=zeros(1,4);
centrey=zeros(1,4);
centrez=zeros(1,4);


centrex(1)=3;
centrey(1)=8;
centrez(1)=3;
len=1.5;
centrex(2)=3;
centrey(2)=9.5;
centrez(2)=3;
centrex(3)=3;
centrey(3)=8;
centrez(3)=4.5;
centrex(4)=3;
centrey(4)=9.5;
centrez(4)=4.5;


%%%%penalty for first arm%%%%
R1=0.5;
R2=sqrt(3)*len/2;

for num=1:obnum
for i=0:5
   dist1=sqrt(power(centrex(num),2)+power((i*sin(theta+pos(a,1))-centrey(num)),2)+power((i*cos(theta+pos(a,1))-centrez(num)),2));
   if ((dist1-R1-R2)<0)
       minval=minval+100*exp(-dist1/(R1+R2));
   end;
end;
end;
       
%%%%penalty for second arm%%%
for num=1:obnum
for j=1:5
   dist2=sqrt(power((j*cos(phi+pos(a,2))-centrex(num)),2)+power((L1*sin(theta+pos(a,1))+j*sin(phi+pos(a,2))-centrey(num)),2)+power((L1*cos(theta+pos(a,1))-centrez(num)),2));
   if ((dist2-R1-R2)<0)
       minval=minval+100*exp(-dist2/(R1+R2));
   end;
end;
end;

%%%%penalty for gripper%%%
for num=1:obnum
dist3=sqrt(power((L2*cos(phi+pos(a,2))-centrex(num)),2)+power((L1*sin(theta+pos(a,1))+L2*sin(phi+pos(a,2))-centrey(num)),2)+power((L1*cos(theta+pos(a,1))+0.5-centrez(num)),2));
dist4=sqrt(power((L2*cos(phi+pos(a,2))-centrex(num)),2)+power((L1*sin(theta+pos(a,1))+L2*sin(phi+pos(a,2))-centrey(num)),2)+power((L1*cos(theta+pos(a,1))-0.5-centrez(num)),2));
   if ((dist3-R1-R2)<0)
       minval=minval+100*exp(-dist3/(R1+R2));
   end;
   if ((dist4-R1-R2)<0)
       minval=minval+100*exp(-dist4/(R1+R2));
   end;
   
dist5=sqrt(power(((L2+0.5)*cos(phi+pos(a,2))-centrex(num)),2)+power((L1*sin(theta+pos(a,1))+(L2+0.5)*sin(phi+pos(a,2))-centrey(num)),2)+power((L1*cos(theta+pos(a,1))+1-centrez(num)),2));
dist6=sqrt(power(((L2+0.5)*cos(phi+pos(a,2))-centrex(num)),2)+power((L1*sin(theta+pos(a,1))+(L2+0.5)*sin(phi+pos(a,2))-centrey(num)),2)+power((L1*cos(theta+pos(a,1))-1-centrez(num)),2));
   if ((dist5-R1-R2)<0)
       minval=minval+100*exp(-dist5/(R1+R2));
   end;
   if ((dist6-R1-R2)<0)
       minval=minval+100*exp(-dist6/(R1+R2));
   end;
end;

%%%%penalty for joint rotation%%%%
%{
if ((theta+pos(a,1))>0.5*pi)
    minval=minval+10000;
end;
if ((phi+pos(a,2))>pi)
    minval=minval+10000;
end;
if ((theta+pos(a,1))<0)
    minval=minval+10000;
end;
if ((phi+pos(a,2))<0)
    minval=minval+10000;
end;
%}
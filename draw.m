axis([-10 10 -10 10 0 20]);
hold on;
grid on;
set(gca,'XDir','rev','YDir','rev','ZDir','rev');
xlabel('x'),ylabel('y'),zlabel('z');
plot3(L2*cos(phi_final_goal),L1*sin(theta_final_goal)+L2*sin(phi_final_goal),L1*cos(theta_final_goal),'o','markersize',8,'MarkerFaceColor','g');

%%%%%%%%%arm%%%%%%%%%%

if(tt==1)
    plot3([0 0],[0 0],[0 20],'r','linewidth',4);
    plot3(0,0,0,'bo','markersize',8,'MarkerFaceColor','b');
    plot3([0 0],[0 (L1-0.4)*sin(theta)],[0 (L1-.4)*cos(theta)],'r','linewidth',4);
    plot3(0,L1*sin(theta),(L1)*cos(theta),'bo','markersize',8,'MarkerFaceColor','b');
    plot3([0 (L2)*cos(phi)],[L1*sin(theta) L1*sin(theta)+(L2)*sin(phi)],[L1*cos(theta) L1*cos(theta)],'r','linewidth',4);
    plot3([(L2)*cos(phi) (L2)*cos(phi)],[L1*sin(theta)+L2*sin(phi) L1*sin(theta)+(L2)*sin(phi)],[L1*cos(theta)-1.5 L1*cos(theta)+1.5],'b','linewidth',4);
    plot3([(L2)*cos(phi) (L2+1)*cos(phi)],[L1*sin(theta)+L2*sin(phi) L1*sin(theta)+(L2+1)*sin(phi)],[L1*cos(theta)+1.2 L1*cos(theta)+0.2],'b','linewidth',4);
    plot3([(L2)*cos(phi) (L2+1)*cos(phi)],[L1*sin(theta)+L2*sin(phi) L1*sin(theta)+(L2+1)*sin(phi)],[L1*cos(theta)-1.2 L1*cos(theta)-0.2],'b','linewidth',4);
else
    plot3([0 0],[0 0],[0 20],'r','linewidth',4);
    plot3(0,0,0,'bo','markersize',8,'MarkerFaceColor','b');
    plot3([0 0],[0 (L1-0.4)*sin(theta)],[0 (L1-.4)*cos(theta)],'r','linewidth',4);
    plot3(0,L1*sin(theta),(L1)*cos(theta),'bo','markersize',8,'MarkerFaceColor','b');
    plot3([0 (L2)*cos(phi)],[L1*sin(theta) L1*sin(theta)+(L2)*sin(phi)],[L1*cos(theta) L1*cos(theta)],'r','linewidth',4);
    plot3([(L2)*cos(phi) (L2)*cos(phi)],[L1*sin(theta)+L2*sin(phi) L1*sin(theta)+(L2)*sin(phi)],[L1*cos(theta)-1.5 L1*cos(theta)+1.5],'b','linewidth',4);
    plot3([(L2)*cos(phi) (L2+1)*cos(phi)],[L1*sin(theta)+L2*sin(phi) L1*sin(theta)+(L2+1)*sin(phi)],[L1*cos(theta)+1.2 L1*cos(theta)+1.2],'b','linewidth',4);
    plot3([(L2)*cos(phi) (L2+1)*cos(phi)],[L1*sin(theta)+L2*sin(phi) L1*sin(theta)+(L2+1)*sin(phi)],[L1*cos(theta)-1.2 L1*cos(theta)-1.2],'b','linewidth',4);
end

%%%%%%%%%%obstacle%%%%%%%%%%%%%

for k=1:obnum
x1(k)=centrex(k)+len/2;
x2(k)=centrex(k)-len/2;
y1(k)=centrey(k)+len/2;
y2(k)=centrey(k)-len/2;
z1(k)=centrez(k)+len/2;
z2(k)=centrez(k)-len/2;
patch([x1(k) x1(k) x2(k) x2(k)],[y1(k) y2(k) y2(k) y1(k)],[z1(k) z1(k) z1(k) z1(k)],'c') 
patch([x1(k) x1(k) x2(k) x2(k)],[y1(k) y2(k) y2(k) y1(k)],[z2(k) z2(k) z2(k) z2(k)],'c') 
patch([x1(k) x1(k) x1(k) x1(k)],[y1(k) y2(k) y2(k) y1(k)],[z1(k) z1(k) z2(k) z2(k)],'c') 
patch([x2(k) x2(k) x2(k) x2(k)],[y1(k) y2(k) y2(k) y1(k)],[z1(k) z1(k) z2(k) z2(k)],'c') 
patch([x1(k) x2(k) x2(k) x1(k)],[y1(k) y1(k) y1(k) y1(k)],[z1(k) z1(k) z2(k) z2(k)],'c') 
patch([x1(k) x2(k) x2(k) x1(k)],[y2(k) y2(k) y2(k) y2(k)],[z1(k) z1(k) z2(k) z2(k)],'c') 
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if(abs(theta)<0.000001)
    th=0;
else
    th=theta;
end
if(abs(phi)<0.000001)
    ph=0;
else
    ph=phi;
end

mTextBox = uicontrol('style','text','String', 'jet|hsv|hot|cool|gray','Position', [20 380 30 20]);
set(mTextBox,'String','theta');
mTextBox = uicontrol('style','text','String', 'jet|hsv|hot|cool|gray','Position', [20 350 30 20]);
set(mTextBox,'String','phi');
mTextBox = uicontrol('style','text','String', 'jet|hsv|hot|cool|gray','Position', [60 380 50 20]);
set(mTextBox,'String',th*180/pi);
mTextBox = uicontrol('style','text','String', 'jet|hsv|hot|cool|gray','Position', [60 350 50 20]);
set(mTextBox,'String',ph*180/pi);

if(rgb==1)
    mTextBox = uicontrol('style','text','String', 'jet|hsv|hot|cool|gray','Position', [120 380 10 20]);
    set(mTextBox,'String',T(kk,1));
    mTextBox = uicontrol('style','text','String', 'jet|hsv|hot|cool|gray','Position', [140 380 20 20]);
    set(mTextBox,'String',T(kk,2));
else
    mTextBox = uicontrol('style','text','String', 'jet|hsv|hot|cool|gray','Position', [120 380 10 20],'BackgroundColor','red');
    set(mTextBox,'String',T(kk,1));
    mTextBox = uicontrol('style','text','String', 'jet|hsv|hot|cool|gray','Position', [140 380 20 20],'BackgroundColor','red');
    set(mTextBox,'String',T(kk,2));
end

if(qp~=0)
    mTextBox = uicontrol('style','text','String', 'jet|hsv|hot|cool|gray','Position', [420 380 120 20],'BackgroundColor','green');
    set(mTextBox,'String','Target Reached!');
end
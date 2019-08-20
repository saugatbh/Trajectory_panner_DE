clc, clear all, close all
num = input ('Enter Subject ID: ');
T = execution(num); 
kk=1;
%T = [2,100;2,100;1,100;2,100;1,100;1,300;2,300;2,300];
display('Enter initial postion');
theta_init = input ('Enter theta_init : ')*pi/180;
phi_init = input ('Enter phi_init: ')*pi/180;

display('Enter goal postion');
theta_final_goal = input ('Enter theta_final : ')*pi/180;
phi_final_goal = input ('Enter phi_final : ')*pi/180;

%obnum=input('Enter no of obstacles(not more than 4):');
obnum = 0;

DELAY = 0.1;
pi = 3.14159;
L1 = 5;
L2 = 5;
chk=0;
qp=0;
rgb=0;

x = L2*cos(phi_final_goal);
y = L1*sin(theta_final_goal)+L2*sin(phi_final_goal);
z = L1*cos(theta_final_goal);

K1=10;
K2=10;

while(1)
    if(kk>length(T))
        kk=1;
    end
    tt=0;
    dt=0;
    dp=0;
    if(T(kk,1)==1)
        if(T(kk,2)==100)
            dp=+10*pi/180;
        elseif(T(kk,2)==200)
            dt=+10*pi/180;
        elseif(T(kk,2)==300)
            tt=+1;
        end
    elseif(T(kk,1)==2)
        if(T(kk,2)==100)
            dp=-10*pi/180;
        elseif(T(kk,2)==200)
            dt=-10*pi/180;
        elseif(T(kk,2)==300)
            tt=-1;
        end
    end
    
    theta_final = theta_init + dt;
    phi_final = phi_init + dp;
    
    if(((x-L2*cos(phi_final))^2 + (y-L1*sin(theta_final)-L2*sin(phi_final))^2 + (z-L1*cos(theta_final))^2)>=((x-L2*cos(phi_init))^2 + (y-L1*sin(theta_init)-L2*sin(phi_init))^2 + (z-L1*cos(theta_init))^2))
        theta_final = theta_init;
        phi_final = phi_init;
    end
    
    if(theta_init==theta_final_goal)
        theta_final = theta_init;
    end
    if(phi_init==phi_final_goal)
        phi_final = phi_init;
    end
    
    if((theta_init<theta_final_goal)&&(theta_final>theta_final_goal))
        theta_final = theta_final_goal;
    end
    if((theta_init>theta_final_goal)&&(theta_final<theta_final_goal))
        theta_final = theta_final_goal;
    end
    if((phi_init<phi_final_goal)&&(phi_final>phi_final_goal))
        phi_final = phi_final_goal;
    end
    if((phi_init>phi_final_goal)&&(phi_final<phi_final_goal))
        phi_final = phi_final_goal;
    end
    
    xx = L2*cos(phi_final);
    yy = L1*sin(theta_final)+L2*sin(phi_final);
    zz = L1*cos(theta_final);

    del_theta=0;
    del_phi=0;
    theta=theta_init;
    phi=phi_init;
    
    rgb=(theta~=theta_final)||(phi~=phi_final)||(tt~=0);    
    if((theta~=theta_final)||(phi~=phi_final)||(tt~=0))  
        while((theta~=theta_final)||(phi~=phi_final))
            lpso;
            theta=theta+del_theta;
            phi=phi+del_phi;
            
            if(((xx-L2*cos(phi))^2 + (yy-L1*sin(theta)-L2*sin(phi))^2 + (zz-L1*cos(theta))^2)<0.01)
                theta=theta_final;
                phi=phi_final;
            end;

            disp(theta*180/pi);
            disp(phi*180/pi);
            clf;
            draw;
            pause(DELAY);
        end
            
    end; 
    
    clf;
    draw;
    pause(DELAY);
    
    if(theta>pi)
        theta=theta-2*pi;
    elseif(theta<=-pi)
        theta=theta+2*pi;
    end
    if(phi>pi)
        phi=phi-2*pi;
    elseif(phi<=-pi)
        phi=phi+2*pi;
    end
    
    if(abs(theta-theta_final_goal)<10^-5)
        theta=theta_final_goal;
    end
    if(abs(phi-phi_final_goal)<10^-5)
        phi=phi_final_goal;
    end
    
    if((theta==theta_final_goal)&&(phi==phi_final_goal)&&(qp==0))
        qp=1;              
    end
    if((theta==theta_final_goal)&&(phi==phi_final_goal))
        qp=qp+1;
    end
    if((theta==theta_init)&&(phi==phi_init))
        chk=chk+1;
    end
    if((theta~=theta_init)||(phi~=phi_init))
        chk=0;
    end
    if((qp>5)||(chk>50))
        if(chk>50)
            disp('ERROR: target cannot be reached with given control signals!')
        end
        break;
    end
    theta_init = theta;
    phi_init = phi;
    tt=0;
    kk=kk+1;
end    
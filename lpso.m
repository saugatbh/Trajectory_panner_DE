 global initial_flag;
    initial_flag=0;
    no_pop=40;
    D=2;
    IRang_R=0.05;
    IRang_L=-0.05;
    maxv=0.05;
    firsttime=1;
    iter=0;
    gbest=1;
    weight=0.29;
    MAXITER=100;
  
    for a=1:no_pop
        
        for b=1:D
            pos(a,b)=(IRang_R-IRang_L)*rand(1)+IRang_L;
            pbestpos(a,b)=pos(a,b);
            vel(a,b)=maxv*rand(1);
        
            if (rand(1)>0.5)
                vel(a,b)=-vel(a,b);
            end;
        end;

        minval=K1*abs(theta_final-pos(a,1)-theta)+K2*abs(phi_final-pos(a,2)-phi);
        obstacle;
        pbestfit(a)=minval;
    end;

    for iter=1:MAXITER
        weight_up=(weight-0.4)*(MAXITER-iter)/MAXITER+0.4;

        for a=1:no_pop
            minval=K1*abs(theta_final-pos(a,1)-theta)+K2*abs(phi_final-pos(a,2)-phi);
            obstacle;
            if(minval<pbestfit(a))
                pbestfit(a)=minval;
                for b=1:D
                    pbestpos(a,b)=pos(a,b);
                end;
            end;

            if (pbestfit(a)<pbestfit(gbest))
                gbest=a;
            end;

            for c=1:no_pop
                if(c==a)
                    euclid_dist(c)=100000;
                    continue;
                end;
                euclid_dist(c)=0;
                for b=1:D
                    euclid_dist(c)=euclid_dist(c)+sqrt(power(pos(a,b)-pos(c,b),2));
                end;
            end;
            
            dist(1:no_pop)=sort(euclid_dist(1:no_pop));
        
            for k=1:5
                for l=1:no_pop
                    if(dist(k)==euclid_dist(l))
                        break;
                    end;
                end;
                sequence(k)=l;
            end;
            
            mincost=pbestfit(sequence(1));
            lbest=sequence(1);
            
            for l=1:5
                if(mincost>pbestfit(sequence(l)))
                    mincost=pbestfit(sequence(l));
                    lbest=sequence(l);
                end;
            end;    


            for b=1:D
                vel(a,b)=weight_up*vel(a,b)+2*rand(1)*(pbestpos(a,b)-pos(a,b))+2*rand(1)*(pbestpos(lbest,b)-pos(a,b));
                if (vel(a,b)>maxv)
                    vel(a,b)=maxv;
                end;
                if(vel(a,b)<-maxv)
                    vel(a,b)=-maxv;
                end;

                pos(a,b)=pos(a,b)+vel(a,b);

                if (pos(a,b)>IRang_R)
                    pos(a,b)=IRang_R;
                end;
                if (pos(a,b)<IRang_L)
                    pos(a,b)=IRang_L;
                end;
            end;
        end;

        firsttime=0;
        mincost=pbestfit(1);
        gbest=1;

        for i=1:no_pop
            if(mincost>pbestfit(i))
                mincost=pbestfit(i);
                gbest=i;
            end;
        end;

    end;
    
    del_theta=pos(gbest,1);
    del_phi=pos(gbest,2);
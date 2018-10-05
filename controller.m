function [ outputs ] = controller( timestamp,inputs )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%% inputs
trans_power_out=inputs(1);
p1=inputs(2);
p2=inputs(3);
p3=inputs(4);
p4=inputs(5);
p5=inputs(6);
t1=inputs(7);
t2=inputs(8);
t3=inputs(9);
t4=inputs(10);
t5=inputs(11);

%% controller
avl_c=(25000-abs(trans_power_out))/240;
% avl_c=avl_c+c1+c2+c3+c4+c5;
c1=0; c2=0; c3=0; c4=0; c5=0;
if(avl_c<0)
    avl_c=0;
elseif (avl_c>30)
    avl_c=30;
end;
b=timestamp;
if(mod(floor(b/600),5)==0)
    if(t1>0)
        c1=avl_c;
    else
        b=b+601;
    end;
end;
if(mod(floor(b/600),5)==1)
    if(t2>0)
        c2=avl_c;
    else
        b=b+601;
    end;
end;
if(mod(floor(b/600),5)==2)
    if(t3>0)
        c3=avl_c;
    else
        b=b+601;
    end;
end;
if(mod(floor(b/600),5)==3)
    if(t4>0)
        c4=avl_c;
    else
        b=b+601;
    end;
end;
if(mod(floor(b/600),5)==4)
    if(t5>0)
        c5=avl_c;
    else
        b=b+600;
    end;
end;


%% outputs
outputs(1)=c1;
outputs(2)=c2;
outputs(3)=c3;
outputs(4)=c4;
outputs(5)=c5;

end


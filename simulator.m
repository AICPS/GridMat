socket = tcpip('localhost', 6267, 'NetworkRole', 'client');
fclose(socket);
fopen(socket);
step=60;
inputs=zeros(86400/step,11);
outputs=zeros(1,5);
for i=0:step:86400
    time=sprintf('2010-07-%02d %02d:%02d:%02d PDT',floor(i/86400)+5,mod(floor(i/3600),24),mod(floor(i/60),60),mod(i,60));
    readValue(socket,['control/pauseat=',time]);
    if(i==86400)
        break;
    end
    state=readValue(socket,'mainloop_state');
    while (strcmp(state,'PAUSED')==0)
        %t1=readValue(socket,'clock');
        state=readValue(socket,'mainloop_state');
        if(strcmp(state,'DONE')==1)
            fclose(socket);
            return;
        end
%         pause(1/1000);
    end
%     v=readValue(socket,'H_1_T_1_BS_646/panel.power');
    j=floor(i/step)+1;
    inputs(j,1)=pValue(socket,'TP_T_1_BS_646/measured_power');
    inputs(j,2)=pValue(socket,'H_1_T_1_BS_646/panel.power');
    inputs(j,3)=pValue(socket,'H_2_T_1_BS_646/panel.power');
    inputs(j,4)=pValue(socket,'H_3_T_1_BS_646/panel.power');
    inputs(j,5)=pValue(socket,'H_4_T_1_BS_646/panel.power');
    inputs(j,6)=pValue(socket,'H_5_T_1_BS_646/panel.power');
    
     inputs(j,7)=pValue(socket,'EV_H_1_T_1_BS_646/time_to_leave_home');
     inputs(j,8)=pValue(socket,'EV_H_2_T_1_BS_646/time_to_leave_home');
     inputs(j,9)=pValue(socket,'EV_H_3_T_1_BS_646/time_to_leave_home');
     inputs(j,10)=pValue(socket,'EV_H_4_T_1_BS_646/time_to_leave_home');
     inputs(j,11)=pValue(socket,'EV_H_5_T_1_BS_646/time_to_leave_home');
     %inputs(j,:)
     outputs=controller(i,inputs(j,:));
%      
     
     readValue(socket,sprintf('EV_H_1_T_1_BS_646/charge_current=%f',outputs(1)));
     readValue(socket,sprintf('EV_H_2_T_1_BS_646/charge_current=%f',outputs(2)));
     readValue(socket,sprintf('EV_H_3_T_1_BS_646/charge_current=%f',outputs(3)));
     readValue(socket,sprintf('EV_H_4_T_1_BS_646/charge_current=%f',outputs(4)));
     readValue(socket,sprintf('EV_H_5_T_1_BS_646/charge_current=%f',outputs(5)));
    
%     avl_c=(25000-abs(trans_power_out)+(p1+p2+p3+p4+p5)*k)/240;
%     v=pValue(socket,'H_1_T_1_BS_646/panel.power');
%      fprintf('[%s]',time);
%      pcon
     
end
fclose(socket);


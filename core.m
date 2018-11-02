function core(handles)
%% get user prameters
glmfile=get(handles.filename_edit,'String');
[starttime,stoptime]=extractdate(glmfile);
steptime=str2double(get(handles.time_edit,'String'));
path='\\aicps-server\ahourai\New\3.0\VS2005\x64\release;\\aicps-server\ahourai\New\3.0\core\rt;';

%% main loop
[pathfile,namefile,ext] = fileparts(glmfile);
datestring = datestr(addtodate(starttime,1,'second'),31);
dos(['cd ',pathfile,' & gridlabd ',namefile,ext,' --server --define pauseat="',datestring,'" &']);
socket = tcpip('localhost', 6267, 'NetworkRole', 'client');
fclose(socket);
contfiles=get(handles.controller_popupmenu,'String');
if(~isempty(contfiles))
    for i=1:size(contfiles,1)
        file=[char(pathfile),'\',char(contfiles(i)),'.m'];
        generateIO(file);
        %dos('');
    end
end
pause(15);
fopen(socket);
loopshow=0;
time=starttime;
while(strcmp(socket.status,'closed')==0 && strcmp(get(handles.time_text,'String'),'Stoping ...')==0)
    date=datestr(time,31);
    if(mod(loopshow,25)==0)
        set(handles.time_text,'String',date);
        pause(0.001);
    end
    readValue(socket,['control/pauseat=',date]);
    state='NONE';
    while (strcmp(state,'PAUSED')==0)
        if(time>stoptime || strcmp(socket.status,'closed')==1 || strcmp(get(handles.time_text,'String'),'Stoping ...')==1)
            contfiles={};
            fclose(socket);
            break;
        end
        pause(0.001);
        state=readValue(socket,'mainloop_state');
    loopshow=loopshow+1;
    end
    %control
    if(~isempty(contfiles))
        for c=1:size(contfiles,1)
            scriptname=char(contfiles(c));
            eval([scriptname,'_i']);
            eval(scriptname);
            eval([scriptname,'_o']);
        end
    end
    time=addtodate(datenum(date,'yyyy-mm-dd HH:MM:SS'),steptime,'second');
end
pause(0.1);
if(strcmp(get(handles.time_text,'String'),'Stoping ...')==1)
    readValue(socket,'control/shutdown');
    set(handles.time_text,'String','Simulation Stopped!');
else
    set(handles.time_text,'String','Simulation Done!');
end
pause(0.1);
fclose(socket);
end

function [start,stop]=extractdate(glmfile)
fid = fopen(glmfile);
tline = fgets(fid);
start=0;
stop=0;
while ischar(tline)
    if(start~=0 && stop~=0)
        break;
    end
    if(~isempty(strfind(tline,'starttime')))
        point=strfind(tline,'''');
        start=datenum(tline(point(1)+1:point(2)-1),'yyyy-mm-dd HH:MM:SS');
    elseif(~isempty(strfind(tline,'stoptime')))
        point=strfind(tline,'''');
        stop=datenum(tline(point(1)+1:point(2)-1),'yyyy-mm-dd HH:MM:SS');
    end
    tline = fgets(fid);
end
fclose(fid);
if(start==0 && stop==0)
    errordlg({'GLM file must have',...
        type},'Input Argument Error!')
end
end
% function [start,stop]=extracttime(glmfile)
% fid = fopen(glmfile);
% tline = fgets(fid);
% start=0;
% stop=0;
% while ischar(tline)
%     if(start~=0 && stop~=0)
%         break;
%     end
%     if(~isempty(strfind(tline,'starttime')))
%         point=strfind(tline,'''');
%         ss=datevec(tline(point(1)+1:point(2)-1),'yyyy-mm-dd HH:MM:SS');
%         start=ss;
%     elseif(~isempty(strfind(tline,'stoptime')))
%         point=strfind(tline,'''');
%         sp=datevec(tline(point(1)+1:point(2)-1),'yyyy-mm-dd HH:MM:SS');
%     end
%     tline = fgets(fid);
% end
% fclose(fid);
% if(start==0 && stop==0)
%     errordlg({'GLM file must have',...
%         type},'Input Argument Error!')
% end
% end
%using workspace
% for c=1:size(contfiles,1)
%         for ii=1:size(inputs,1)
%             ws.(char(inputs{c}(ii,2)))=pow(socket,char(inputs{c}(ii,1)));
%         end
%         eval(contfiles(c));
%         for oo=1:size(outputs,1)
%             ws.(outputs{c}(oo,1))=pow(socket,outputs{c}(oo,2));
%         end
%     end

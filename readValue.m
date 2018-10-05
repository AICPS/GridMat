function [ string,str ] = readValue( socket, command )
command=strrep(command,' ','%20');
fwrite(socket,['GET /',command,' HTTP/1.1']);
string='';
i=0;
while(1)
    i=i+1;
    if(socket.BytesAvailable>0)
        str=sprintf('%s',fread(socket,socket.BytesAvailable, 'char'));
        string=str(strfind(str,'<value>')+7:strfind(str,'</value>')-1);
    end
    if(~isempty(string) || strcmp(command(1:8),'control/')==1)
        break;
    end
    if(i> 3000)
        fclose(socket);
        fprintf("Simulation Complete\n");
        break;
    end
end
end


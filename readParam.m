function [ data ] = readParam( filename,type )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
% type = 'ALL' or 'INPUT' or 'OUTPUT'
fid = fopen(filename);
data={};
tline = fgets(fid);
while (ischar(tline) && isempty(strfind(tline,'%#END')))
    pos1=strfind(tline,'%#');
    if(~isempty(pos1))
        t=int16(tline(pos1+2));
        pos2=strfind(tline,'=');
        pos3=strfind(tline,';');
        if(t==73)
            name='Input';
        elseif(t==79)
            name='Output';
        elseif(t==66)
            name='Bidirection';
        else
            tline = fgets(fid);
            continue;
        end
        tdata={strtrim(tline(pos1+4:pos2-1)),strtrim(tline(pos2+1:pos3-1)),name};
        if(strcmp(type,'ALL')==1)
            data=cat(1,data,tdata);
        elseif(t==66 || t==int16(type(1)))
            data=cat(1,data,tdata(1:2));
        end
    end
    tline = fgets(fid);
end
fclose(fid);
end


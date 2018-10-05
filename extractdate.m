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
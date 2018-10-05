function pow = pValue( socket, value )
    [str,ss]=readValue(socket,value);
    unit=strfind(str,' ');
    if(strcmp(str(unit-1),'d'))
        str(unit-1)='j';
    end
    if(isempty(unit))
        pow=abs(str2double(str));
    else
        pow=abs(str2double(str(1:unit-1)));
    end
    if(isnan(pow))
        fprintf('**********%s -> %s\n',ss,str);
    end
    if(strcmp(str(unit+1),'k')==1)
        pow=pow*1000;
    end
end


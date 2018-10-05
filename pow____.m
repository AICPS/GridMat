function pow = pValue( socket, value )
    str=readValue(socket,value);
    unit=strfind(str,' ');
    pow=abs(str2double(str(1:unit-1)));
    if(strcmp(str(unit+1),'k')==1)
        pow=pow*1000;
    end
end


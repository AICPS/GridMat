function generateIO( file )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
[pathfile,namefile,ext] = fileparts(file);

inputs=readParam(file,'Input');
fid=fopen([pathfile,'\',namefile,'_i',ext],'w');
for i=1:size(inputs,1)
    fprintf(fid,'%s=pValue(socket,''%s'');\n',char(inputs(i,2)),char(inputs(i,1)));
end
fclose(fid);

outputs=readParam(file,'Output');
fid=fopen([pathfile,'\',namefile,'_o',ext],'w');
for i=1:size(outputs,1)
   fprintf(fid,'readValue(socket,sprintf(''%s=%%f'',%s));\n',char(outputs(i,1)),char(outputs(i,2)));
end
fclose(fid);
end


function [input_size, output_size] = generateIOU( file )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
[pathfile,namefile,ext] = fileparts(file);

inputs=readParam(file,'Input');
fid=fopen([pathfile,'\',namefile,'_i',ext],'w');
input_size=size(inputs,1);
for i=1:input_size
   fprintf(fid,'block.OutputPort(2).Data(%d)=pValue(socket,''%s'');\n',i,char(inputs(i,1)));
%     fprintf(fid,'y(%d)=pValue(socket,''%s'');\n',i,char(inputs(i,1)));
end
fclose(fid);

outputs=readParam(file,'Output');
fid=fopen([pathfile,'\',namefile,'_o',ext],'w');
output_size=size(outputs,1);
for i=1:output_size
   fprintf(fid,'readValue(socket,sprintf(''%s=%%f'',u(%d)));\n',char(outputs(i,1)),i);
end
fclose(fid);
end


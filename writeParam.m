function writeParam( filename , data)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
% type = 'ALL' or 'INPUT' or 'OUTPUT'
fid = fopen(filename);
tline = fgets(fid);
while (ischar(tline) && strcmp(tline(1:5),'%#END')==0)
    tline = fgets(fid);
end
buffer=fread(fid);
fclose(fid);
temp=sprintf('%%#PARAM\n');
for i=1: size(data,1)
   temp=sprintf('%s%%#%c %s=%s;\n',temp,data{i,3}(1),data{i,1},data{i,2});
end    
temp=sprintf('%s%%#END\n',temp);
fid = fopen(filename,'w');
fwrite(fid,[temp,buffer']);
fclose(fid);
end


clear all;
clc;
%%change name
findnumber=dir('*.csv');
total = 23; %文件总数
start = 53; %文件起始位置
endnum = start + total-1;
loadname=zeros(1,total);
cache=[];
data=[];
for i=start:endnum
    cell_str=strsplit(findnumber(i).name,'_');
    name=cell_str{2};
    name=strrep(name,'.CSV','');
    newnumber=str2num(name);
    namenumber=newnumber-40;
    namestr=num2str(namenumber);
    newname=[namestr,'K.txt'];
    oldname=findnumber(i).name;
    copyfile(oldname,newname);
    index=i-start+1;
    loadname(index)=namenumber;    
    fid = fopen(newname,'r');
    FormatString=repmat('%f;',1,2);
    cache=textscan(fid,FormatString,1032,'headerlines',31);
    cache=cell2mat(cache);
    data=[data,cache(:,2)];
end
% filenumber=linspace(900,1700,n);
% for i=1:length(filenumber)
%     oldname=findnumber(i).name;
%     newname=[num2str(filenumber(i)),'.txt'];
%     %     eval(['!rename' 32 oldname 32 newname]);
%     copyfile(oldname,newname);
% end;

% filenumber=450:10:950;

% for i=1:n
%     name=[num2str(filenumber(i)),'.txt'];
%     cache=load(name);
%     data=[data,cache(:,2)];
% end
data=[cache(:,1),data];
data=[0,loadname;data];
[a,b]=size(data);
data=data(1:a-2,:);

fid=fopen('Index1_780mA_mapping_13K_35K.txt','w');
FPSI=data;
[m,q]=size(FPSI);
for nn=1:1:m   % 1001
    for nnn=1:1:q  % 23
        if nnn==q
            fprintf(fid,'%20.7e\n',FPSI(nn,nnn));
        else
            fprintf(fid,'%20.7e\t',FPSI(nn,nnn));
        end
    end
end
fclose(fid);
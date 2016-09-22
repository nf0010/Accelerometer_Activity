function [data,Activity,Intensity]=extractFeatures(gx,gy,gz,activity, intensity,Win)
%norm
NoOfSeg=floor(length(gx)/Win);
AccCom1=sqrt((gx.^2)+(gy.^2)+(gz.^2));  %combined accelerometer data 
AccCom=reshape(AccCom1(1:NoOfSeg*Win)',[Win,NoOfSeg])';

f1 = sum(AccCom,2);
f2 = mean(AccCom,2);
f3 = std(AccCom,1,2);
f4 = f2./f3;
f5 = max(AccCom')' - min(AccCom')';
f15 = sum(AccCom.^2,2);
f16 = sum(log(AccCom.^2),2);
f17 = sum(sign(AccCom-repmat((f2+f3./3)',Win,1)')+ones(size(AccCom)),2)./2;
f18 = sum(sign(AccCom-repmat(median(AccCom,2)',Win,1)')+ones(size(AccCom)),2)./2;
f12=zeros(size(f1));
for i=1:length(f1)
    temp=autocorr(AccCom(i,:),1);
    f12(i)=temp(2);
end
data=[f1';f2';f3';f4';f5';f12';f15';f16';f17';f18']';

Activity=zeros(size(gx));
ActivityList={'warm up','knee lifts','hamstring curls','Spotty dogs','jacks','leg mambo','Marching on spot','bench steps','Warm down'};

count=1;  %for each label obtain the data segment from the original data
for i=1:9
    while strcmp(activity{count},ActivityList{i}) && count<length(gx)
        Activity(count)=i;
        count=count+1;
    end        
end
Activity=reshape(Activity(1:NoOfSeg*Win)',[Win,NoOfSeg])';
Activity=mode(Activity,2);

Intensity=zeros(size(gx));
IntensityList={'Low','High'};

for i=1:length(gx)
    if isempty(intensity{i}) 
        Intensity(i)=0;
    elseif strcmp(intensity{i},IntensityList{1})
        Intensity(i)=1;
    else
        Intensity(i)=2;
    end
end
Intensity=reshape(Intensity(1:NoOfSeg*Win)',[Win,NoOfSeg])';
Intensity=mode(Intensity,2);

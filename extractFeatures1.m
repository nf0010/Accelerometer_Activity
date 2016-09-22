function data=extractFeatures1(gx,gy,gz,activity, Window)
%norm
T=length(gx);
NoOfSeg=floor(T/Window);
 
AccCom=sqrt((gx.^2)+(gy.^2)+(gz.^2));  %combined accelerometer data 
 
ActivityList={'warm up','knee lifts','hamstring curls','Spotty dogs','jacks','leg mambo','Marching on spot','bench steps','Warm down'};
 
 
start=1;
count=1;  %for each label obtain the data segment from the original data
for i=1:9
    try
       out=activity{count}-ActivityList{i};
    catch
        out=1;
    end
    while sum(out)==0 && count<T
            try
                out=activity{count}-ActivityList{i};
            catch
                out=1;
            end
        count=count+1;
    end
    OutLabelData{i}=AccCom(start:count-1);
    start=count;    
end
 
 
 
for i=1:9    %obtain features  
    temp=OutLabelData{i};
    L=floor(length(temp)/Window);
    for j=1:L-1
            TempFeature(1,j)=mean(temp((j-1)*Window+1:j*Window))-1; %calculate features here
            TempFeature(2,j)=std(temp((j-1)*Window+1:j*Window)); 
    end
    CellofFeaturesLabel{i}=TempFeature;
    clear TempFeature;
end
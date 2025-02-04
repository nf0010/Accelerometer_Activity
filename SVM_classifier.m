%%******************************************
clear
folder = '/Users/nazlidavar/Documents/eHealth/Datasets/AccelerometerBristol/for_surrey_csv/';
files=dir(folder);
filename2=files(end).name;
Win=100;pca_c=5;
filename2=strcat(folder,filename2);
x_train=[];y_train=[];level_train=[];
for f=3:length(files)-2
    filename=strcat(folder,files(f).name);
    if ~isempty(strfind(filename,'_3_raw.csv'))
        [VarName1,id,date_time,gx,gy,gz,x_jerk,y_jerk,vec_mag,z_jerk,ms,gap,activity,intensity,flip1,line1] = importfile(filename);
        [x_train_tmp,y_train_tmp,level_train_tmp]=extractFeatures(gx,gy,gz,activity, intensity,Win);
        x_train=[x_train;normr(x_train_tmp)];
        y_train=[y_train;y_train_tmp];
        level_train=[level_train;level_train_tmp];
    end
end
[VarName1,id,date_time,gx,gy,gz,x_jerk,y_jerk,vec_mag,z_jerk,ms,gap,activity,intensity,flip1,line1] = importfile(filename2);
[x_test,y_test,level_test]=extractFeatures(gx,gy,gz,activity, intensity,Win);
x_test=normr(x_test);
x_train1=x_train(level_train==1,:);y_train1=y_train(level_train==1)-1;
x_train2=x_train(level_train==2,:);y_train2=y_train(level_train==2)-1;
x_test1=x_test(level_test==1,:);y_test1=y_test(level_test==1,:)-1;
x_test2=x_test(level_test==2,:);y_test2=y_test(level_test==2,:)-1;

% [COEFF,SCORE_train] = princomp(normc(x_train1)); 
% x_train1=SCORE_train(:,1:pca_c);
% SCORE_test=normc(x_test1)*COEFF;
% x_test1=SCORE_test(:,1:pca_c);
TRAIN=x_train2;

TRAIN_ans=y_train2;

%****************************************************************
TEST=x_test2;

TEST_ans=y_test2;

 x=[1:size(x_train2,2)]; 
    
[result] = multisvm(TRAIN(:,x),TRAIN_ans(:,:),TEST(:,x));
C = confusionmat(y_test2,result);
kappa(C)

% cr(1,6)=cr(1,1)/sum(cr(1,:));
% cr(2,6)=cr(2,2)/sum(cr(2,:));
% cr(3,6)=cr(3,3)/sum(cr(3,:));
% cr(4,6)=cr(4,4)/sum(cr(4,:));
% cr(5,6)=cr(5,5)/sum(cr(5,:));
% 
% cr(6,1)=cr(1,1)/sum(cr(:,1));
% cr(6,2)=cr(2,2)/sum(cr(:,2));
% cr(6,3)=cr(3,3)/sum(cr(:,3));
% cr(6,4)=cr(4,4)/sum(cr(:,4));
% cr(6,5)=cr(5,5)/sum(cr(:,5));
% 
% cr
% sen=mean(cr(1:5,6));spe=mean(cr(6,1:5));
% [sen,spe]
% 
% APER(1,:)=[length(find(r_Total==0))/length(r_Total),...
% length(find(r_Total==1))/length(r_Total),...
% length(find(r_Total==2))/length(r_Total),...
% length(find(r_Total==3))/length(r_Total),...
% length(find(r_Total==5))/length(r_Total)];
% 
% APER(2,:)=[length(find(m_Total==0))/length(m_Total)+length(find(m_Total==9))/length(m_Total),...
% length(find(m_Total==1))/length(m_Total),...
% length(find(m_Total==2))/length(m_Total),...
% length(find(m_Total==3))/length(m_Total),...
% length(find(m_Total==5))/length(m_Total)];
% APER


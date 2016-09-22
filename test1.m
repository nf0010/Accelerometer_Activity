folder = '/Users/nazlidavar/Documents/eHealth/Datasets/AccelerometerBristol/for_surrey_csv/';
filename='3473_3_raw.csv';
[RowIndex,id,date_time,gx,gy,gz,x_jerk,y_jerk,vec_mag,z_jerk,ms,gap,activity,intensity,flip1,line1] = importfile(strcat(folder,filename));
Window=200;  
data=extractFeatures(gx,gy,gz,acitvity,Window);
 


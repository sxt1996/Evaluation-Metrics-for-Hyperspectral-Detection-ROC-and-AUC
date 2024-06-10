clear all;  
clc; 
close all

%% read the HSI data being processed

a = dir;   
filename_path = a.folder;     
filename_path = strcat(filename_path,'\');
name_HSI = 'cut_1';     

filename = strcat(filename_path,name_HSI,'.mat');

load(filename);

X_cube = data;
clear('data');
[samples,lines,band_num]=size(X_cube);
pixel_num = samples * lines;

gt = map;
clear('map');

mask = reshape(gt, 1, pixel_num);   



%% load detection result
name_result = 'result';
filename_result = strcat(filename_path, name_result, '.mat');
load(filename_result);


result_2D = reshape(result, samples, lines);   

%% illustrate detection result
figure;
subplot(121), imagesc(gt); axis image;   title('Ground Truth')     
subplot(122), imagesc(result_2D); axis image;   title('Detection map of TD-IEEPST')    

%% evaluate detection results with ROC 

figure;
AUC = ROC(mask,result,'r')       


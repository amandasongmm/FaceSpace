
close all; 
clear; 
clc; 

addpath('');
load('faceImgArray.mat');
load('faceGenderNewList.mat');
faceData = faceImgArray;
faceGenderData = faceGender;
[imH, imW, imN] = size(faceData);
faceData = reshape(faceData, imH*imW, imN);
mu = mean(faceData);
faceData = faceData'; % 277*25k
no_dim =2;
initial_dims = 30;
perplexity = 30;
theta = 0.9;
mappedX = fast_tsne(faceData, no_dims, initial_dims, perplexity, theta);

gscatter(mappedX(:,1), mappedX(:,2), faceGenderData, 'o');
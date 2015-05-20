
close all; 
clear; 
clc; 
load('faceImgArray.mat');
faceData = faceImgArray;
[imH, imW, imN] = size(faceData);
faceData = reshape(faceData, imH*imW, imN);
mu = mean(faceData);
faceData = faceData'; % 277*25k
[cof, newRep] = pca(faceData);

no_dim =276; 
recFace = newRep(:,1:no_dim) * cof(:,1:no_dim)';

%% reshape it back
recFace = recFace'; 
recFace = bsxfun(@plus,mu,recFace);
recFace = reshape(recFace, imH, imW, imN);

%% 



%% compare before and after reconstruction. 
randNum = 4; 
titleStr = sprintf('No of dimen = %d, No of Im = %d',no_dim, randNum);
figure; 
subplot(2,1,1);
imshow(faceImgArray(:,:,randNum),[]);
subplot(2,1,2);
imshow(recFace(:,:,randNum),[]);
title(titleStr);


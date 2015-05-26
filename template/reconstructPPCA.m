%% initialization
close all; clear; clc;

% add the dr toolbox into the matlab folder.
addpath('../drtoolbox');
addpath('../drtoolbox/gui');
addpath('../drtoolbox/techniques');
addpath('../');

load('ex7faces.mat');%5000*1024. X imN * imFeature
imH = 32; imW = 32; imN = 5000; 
% % load the face images.
% load('../faceImgArray.mat');%faceImgArray 181*139*277
% load('../faceGenderNewList.mat');%faceGender 277*1
% [imH, imW, imN] = size(faceImgArray);
% 
% % reshape it into a 2d array
% faceImgArray = reshape(faceImgArray, imH*imW, imN);
% faceImgArray = faceImgArray'; % to adjust the input into imN*imFeature

%% dimensionality reduction and reconstruction

% % first apply PCA before throw it into PPCA.
[pca_mappedX, pca_mapping] = compute_mapping(X, 'PCA', 1000);

reducedDimArray = [200];
numItr = 15;
for curItr = 1 : length(reducedDimArray)
    
    reducedDim = reducedDimArray(curItr);
    
    %'PCA' should be changed into your own method, it may require more input argu for your method
    [ppca_mappedX, ppca_mapping] = compute_mapping(pca_mappedX, 'PPCA', reducedDim, numItr);
    recX_PPCA = reconstruct_data(ppca_mappedX, ppca_mapping);%recX = imN * imFeature
    recX_PCA = reconstruct_data(recX_PPCA, pca_mapping);
    
    % change recX into imH * imW * imN
    recX = reshape(recX_PCA', imH, imW, imN);
    
    %% plot reconstructed image
    titleStr = sprintf('PPCA: ReconstructedFrom%dDimensions',reducedDim);
    figure;
    h = displayData(recX(:,:,1:4));
    title(titleStr);
end

%% plot original image.
figure;
oriX = reshape(X', imH, imW, imN);
h = displayData(oriX(:,:,1:4));
title('Original Images');

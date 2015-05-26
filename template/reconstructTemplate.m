% use DRtoolbox to reconstruct images from reduced dimensions.

%function reconstructTemplate

close all; clear; clc;

% add the dr toolbox into the matlab folder.
addpath('../drtoolbox');
addpath('../drtoolbox/gui');
addpath('../drtoolbox/techniques');
addpath('../');

load('../faceImgArray.mat');%faceImgArray 181*139*277
[imH, imW, imN] = size(faceImgArray);

% reshape it into a 2d array
faceImgArray = reshape(faceImgArray, imH*imW, imN);
faceImgArray = faceImgArray'; % to adjust the input into imN*imFeature

reducedDimArray = [1,2,3,4,5,6,7, 20]%, 60, 100, 140, 150, 160, 170, 180, 220, 277]; 
% we tried to reconstruct images from the above dimensions and we find for
% PCA, 150 is the sweet spot. 

for curItr = 1 : length(reducedDimArray)
    reducedDim = reducedDimArray(curItr);
    [mappedX, mapping] = compute_mapping(faceImgArray, 'PCA',reducedDim);
    %'PCA' should be changed into your own method, it may require more input argu for your method
    recX = reconstruct_data(mappedX, mapping);%recX = imN * imFeature
    % change recX into imH * imW * imN
    recX = reshape(recX', imH, imW, imN);
    
    titleStr = sprintf('PCA: Reconstruction From %d Dimensions',reducedDim);
    saveStr = sprintf('%s.jpeg',titleStr);
    figure;
    h = displayData(recX(:,:,1:4));
    title(titleStr);
end

figure;
oriX = reshape(faceImgArray', imH, imW, imN);
h = displayData(oriX(:,:,1:4));
title('Original Images');
%end

% use DRtoolbox to reconstruct images from reduced dimensions.

%function reconstructTemplate

close all; clear; clc;

% add the dr toolbox into the matlab folder.
addpath('../drtoolbox');
addpath('../drtoolbox/gui');
addpath('../drtoolbox/techniques');
addpath('../');

load('../faceImgArray.mat');%faceImgArray 181*139*277
load('../faceGenderNewList.mat');%faceGender 277*1
[imH, imW, imN] = size(faceImgArray);

% reshape it into a 2d array
faceImgArray = reshape(faceImgArray, imH*imW, imN);
faceImgArray = faceImgArray'; % to adjust the input into imN*imFeature

%reducedDimArray = [20, 60, 100, 140, 150, 160, 170, 180, 220, 277];
% we tried to reconstruct images from the above dimensions and we find for
% PCA, 150 is the sweet spot.


reducedDim = 200;
%[pca_mappedX, pca_mapping] = compute_mapping(faceImgArray, 'PCA', 276);

%'PCA' should be changed into your own method, it may require more input argu for your method
LabeledFaceData = [faceGender, faceImgArray];
[nca_mappedX, nca_mapping] = compute_mapping(LabeledFaceData, 'NCA', reducedDim);
recX_NCA = reconstruct_data(nca_mappedX, nca_mapping);%recX = imN * imFeature
%recX_PCA = reconstruct_data(recX_NCA, pca_mapping);

% change recX into imH * imW * imN
recX = reshape(recX_NCA', imH, imW, imN);

titleStr = sprintf('NCA: ReconstructedFrom%dDimensions',reducedDim);
%
%saveStr = sprintf('%s.jpeg',titleStr);
figure;
h = displayData(recX(:,:,1:4));
%title(titleStr);
%[saveStr, false] = imsave(h);


figure;
oriX = reshape(faceImgArray', imH, imW, imN);
h = displayData(oriX(:,:,1:4));
title('Original Images');

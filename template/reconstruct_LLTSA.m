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

reducedDimArray = [ 150,50,150, 160, 220];
% we tried to reconstruct images from the above dimensions and we find for
% PCA, 150 is the sweet spot.

for curItr = 1 %: length(reducedDimArray)
    reducedDim = reducedDimArray(curItr);
    size(faceImgArray);
    for no_neighbor = 12%60 : 80
        [pca_mappedX, pca_mapping] = compute_mapping(faceImgArray, 'PCA', 276);
        
        %'PCA' should be changed into your own method, it may require more input argu for your method
        
        [lpp_mappedX, lpp_mapping] = compute_mapping(pca_mappedX, 'LLTSA', reducedDim, no_neighbor, 'Matlab');
        recX_LPP = reconstruct_data(lpp_mappedX, lpp_mapping);%recX = imN * imFeature
        recX_PCA = reconstruct_data(recX_LPP, pca_mapping);
        
        % change recX into imH * imW * imN
        recX = reshape(recX_PCA', imH, imW, imN);
        
        titleStr = sprintf('LDA: ReconstructedFrom%dDimensions',reducedDim);
        %
        %saveStr = sprintf('%s.jpeg',titleStr);
        figure;
        h = displayData(recX(:,:,1:25));
        %title(titleStr);
        %[saveStr, false] = imsave(h);
    end
end


figure;
oriX = reshape(faceImgArray', imH, imW, imN);
h = displayData(oriX(:,:,1:25));
title('Original Images');
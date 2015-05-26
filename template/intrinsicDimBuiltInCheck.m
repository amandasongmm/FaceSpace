

close all; clear; clc; 

addpath('../drtoolbox');
addpath('../drtoolbox/gui');
addpath('../drtoolbox/techniques');
addpath('../');

load('../faceImgArray.mat');%faceImgArray 181*139*277
[imH, imW, imN] = size(faceImgArray);
% reshape it into a 2d array
faceImgArray = reshape(faceImgArray, imH*imW, imN);
faceImgArray = faceImgArray'; % to adjust the input into imN*imFeature

intriDim = intrinsic_dim(faceImgArray, 'EigValue');
display(intriDim);
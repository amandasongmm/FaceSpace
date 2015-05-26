% we want to move the image along the first few principal components and
% examine the impact on reconstruction.

close all; clear; clc;

%% add the dr toolbox into the matlab folder.
addpath('../drtoolbox');
addpath('../drtoolbox/gui');
addpath('../drtoolbox/techniques');
addpath('../');

%% load and reshape faceImgArray
load('../faceImgArray.mat');%faceImgArray 181*139*277
[imH, imW, imN] = size(faceImgArray);

% reshape it into a 2d array
faceImgArray = reshape(faceImgArray, imH*imW, imN);
faceImgArray = faceImgArray'; % to adjust the input into imN*imFeature


%%
reducedDim = 150;
[mappedX, mapping] = compute_mapping(faceImgArray, 'PCA',reducedDim);
% mappedX: imNum * reducedDim

comIndList = [1:6];
faceID = 200; 
for curComInd = 1 : length(comIndList)  
    % move 1st PC
    comInd = comIndList(curComInd);
    PCstd = std(mappedX(:,comInd)); %
    PCArray = PCstd * [-10:10]';%21 continuous change
    mappedTemp = mappedX;
    
    figure;
    titleStr = sprintf('Move along PC %d, face %d',comInd,faceID);
    title(titleStr);
    for curItr = 1 : length(PCArray)
        mappedTemp(:,comInd) = bsxfun(@plus,mappedX(:,comInd),PCArray(curItr));
        recX = reconstruct_data(mappedTemp, mapping);
        recX = reshape(recX', imH, imW, imN);
        subplot(3,7,curItr);
        imshow(recX(:,:,faceID),[]);
    end
end



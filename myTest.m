%[X, labels] = generate_data('helix', 2000);

clc; clear; close all; 
%% load data.
load('faceImgArray.mat');
fa = faceImgArray;
[imH, imW, imN] = size(fa);
X = reshape(faceImgArray, [imH * imW, imN]);%
X = X'; %imN * imFeatureNum





load('faceGenderNewList.mat');
labels = faceGender; 






[mappedX, mapping] = compute_mapping(X, 'PCA',200);	
X = [labels, mappedX];
%% visualize data using different algorithms
% figure;
% scatter3(X(:,1), X(:,2), X(:,3), 5, labels); 
% title('Original dataset');
% drawnow;

% no_dims = round(intrinsic_dim(X, 'MLE'));
% disp(['MLE estimate of intrinsic dimensionality: ' num2str(no_dims)]);

[mappedX, mapping] = compute_mapping(X, 'NCA');	
figure; scatter(mappedX(:,1), mappedX(:,2), 5, labels); 
title('Result of NCA');

% [mappedX, mapping] = compute_mapping(X, 'Laplacian', no_dims, 7);	
% figure;
% scatter(mappedX(:,1), mappedX(:,2), 5, labels(mapping.conn_comp)); 
% title('Result of Laplacian Eigenmaps'); drawnow;
% 
% 
% [mappedX, mapping] = compute_mapping(X, 'Sammon',no_dims);
% figure; scatter(mappedX(:,1),mappedX(:,2),5,labels);
% title('Result of Sammon');
% 
% [mappedX1, mapping1] = compute_mapping(X, 'Isomap',no_dims);
% figure; scatter(mappedX1(:,1), mappedX1(:,2), 5, labels(mapping1.conn_comp)); 
% title('Result of Isomap');

% [mappedX, mapping] = compute_mapping(X, 'ProbPCA', no_dims);
% figure; scatter(mappedX(:,1), mappedX(:,2), 5, labels); 
% title('Result of Probabilistic PCA');

% [mappedX, mapping] = compute_mapping(X, 'FactorAnalysis', no_dims);
% figure; scatter(mappedX(:,1), mappedX(:,2), 5, labels); 
% title('Result of Factor Analysis');





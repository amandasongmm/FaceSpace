function h = displayData(imArray)
%DISPLAYDATA Display 2D data in a nice grid
%   [h, display_array] = DISPLAYDATA(X, example_width) displays 2D data
%   stored in X in a nice grid. It returns the figure handle h and the
%   displayed array if requested.
% First wrote by machine learning coursera group.
% Last edited by Amanda Song, Apr 8th, 2015
% suppose your imArray is stored in 3d, with size imH* imW* imNum

if ~exist('imArray','var')||isempty(imArray)
    load('initData.mat');% replace it with the imageArray that have landmark on it. 
    imArray = faceImgArray; 
end

% Gray Image
colormap(gray);

% prepare imH, imW, imNum
[imH, imW, imNum] = size(imArray);

% compute number of items to display
display_rows = ceil(sqrt(imNum));
display_cols = ceil(imNum/display_rows);

% Between images padding
pad = 2;

% setup blank display
display_array = ones(pad + display_rows * (imH + pad), ...
	pad + display_cols * (imW + pad));

% copy each image into a patch on the display array
curInd = 1;
for curR = 1 : display_rows
	for curC = 1 : display_cols
		if curInd > imNum
			break;
        end
		% get the max value of each patch
        curPatch = imArray(:,:,curInd);
        max_val = max(abs(curPatch(:)));
        
		display_array(pad + (curR-1)*(imH+pad)+(1:imH), ...
					  pad + (curC-1)*(imW+pad)+(1:imW)) = imArray(:, :, curInd)/max_val;
		curInd = curInd + 1;
		
		if curInd > imNum
			break; 
		end
	end
end

% display image
h = imagesc(display_array, [-1 1]);
axis image off
drawnow; 
end
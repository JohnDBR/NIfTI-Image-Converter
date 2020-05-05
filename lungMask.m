function cropped = lungMask(data)
I = data;

%% Threshold to isolate lungs.
thresholded = I < 0.3;

%% Remove the border.
clearThresh = imclearborder(thresholded);

%% Remove objects less than 100 pixels.
cleared = bwareaopen(clearThresh,100); 

%% Fill in the vessels inside the lungs.
filled = imfill(cleared,'hole');

cropped = filled.*I;
end
function cropped = lungMask(data)
I = uint8(data);

%% Threshold to isolate lungs.
thresholded = I < 0.9;

%% Remove the border.
clearThresh = imclearborder(thresholded);

%% Remove objects less than 100 pixels.
cleared = bwareaopen(clearThresh,100); 

%% Fill in the vessels inside the lungs.
filled = uint8(imfill(cleared,'hole'));

cropped = filled.*I;
end
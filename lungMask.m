I=im2double(imread('./90/png/coronacases_org_001/coronacases_org_001_slice_117.png'));
I=I(:,:,1);
imshow(I)
cropped = I; %% Crop region of interest   
thresholded = cropped < 0.3; %% Threshold to isolate lungs %% for nii images converted to png 0.3 an for pre processed images 0.9
clearThresh = imclearborder(thresholded); %% Remove border artifacts in image   
Liver = bwareaopen(clearThresh,100); %% Remove objects less than 100 pixels
Liver1 = imfill(Liver,'hole'); % fill in the vessels inside the lungs
figure,imshow(Liver1.*cropped)

function masked = dcm2masked(path)

    file_info = dicominfo(path);
    image_data = dicomread(file_info);%cargamos la imagen dicom
    raw_image = uint8(255 * mat2gray(image_data)); %% Apply Grayscale
    layers = im2double(raw_image);%pasamos la imagen a double
    image = layers (:,:,1);
    %%imshow(image, []);
    %cropped = image(50:430,8:500); %% Crop region of interest  (50:430,8:500) 
    thresholded = image < 0.23; %% Threshold to isolate lungs %% for nii images converted to png 0.3 an for preprocessed immages 0.9
    clearThresh = imclearborder(thresholded); %% Remove border artifacts in image   
    Liver = bwareaopen(clearThresh,100); %% Remove objects less than 100 pixels
    filled = imfill(Liver, 'hole'); % fill in the vessels inside the lungs  
    masked = filled.*image;
end


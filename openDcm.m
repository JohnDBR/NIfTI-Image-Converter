clc;
close all;

%% SELECT FILE WITHIN THE DATASETS FOLDER
[file, path] = uigetfile('../../../../../MATLAB/DATA MINING/COVID/AIUDA_DATASET/LCTSC/*.dcm');
    
%% READ .dcm
for t = 0.3: -0.01: 0.1
    image = dcm2masked(fullfile(path, file));
    figure; imshow(image, []);
end
clc;
close all;

%% SELECT FILE WITHIN THE DATASETS FOLDER
[file, path] = uigetfile('../DATASETS/*.nii');

%% READ .nii
image = niftiread(fullfile(path, file));

%% PREVIEW .nii
volumeViewer(image);
clc;
close all;
addpath('./');  

%% SELECT FILE
[file,path] = uigetfile('*.png');

%% PROCESS THE FILE
if isequal(file,0)
   disp('User selected Cancel');
else
    %% READ IMAGE
    XY = imread(fullfile(path,file));    
    image = uint8(rgb2gray(XY));
    %% LUNG MASK
    cropped = lungMask(image);
    
    %% RESIZE
    resized = imresize(cropped, [512, 512]);
    
    %% SAVE
    pngFileName = "aqui_llego_tu_tiburon.png";
    imwrite(resized, char(pngFileName));
end
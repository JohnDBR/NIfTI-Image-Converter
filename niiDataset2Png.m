clc;
close all;

%% SELECT THE DATASET DIRECTORY
sourceDirectory = uigetdir('../DATASETS', 'Select the .nii dataset folder');

%% SELECT THE WORKING DIRECTORY
workingDirectory = uigetdir(pwd, ...
    'Select thew folder where you want to store the extracted .png files');
cd(workingDirectory);

%% SET ROTATION FOR .nii FILES
% ask user to rotate and by how much
rotation = 0;
hasRotation = input(' Would you like to rotate the orientation? (y/n) ', 's');
if lower(hasRotation) == 'y'
   rotation = str2double(input('OK. By 90° 180° or 270°? ', 's'));
   if rotation == 90 || rotation == 180 || rotation == 270
       disp('Got it. Your images will be rotated.');
   else
       disp('Invalid input...');
       exit;
   end
elseif lower(hasRotation) ~= 'n' && lower(hasRotation) ~= 'y'
   disp('Invalid input...');
   exit;
end

%% SELECT ALL .nii FILES
niiFiles = dir(fullfile(sourceDirectory, '*.nii'));

%% CREATE RESULT DIRECTORY
mkdir png
cd('./png');

%% ITERATE .nii FILES
fprintf('Number of files in the source directory: %d\n', length(niiFiles));
for fileIndex = 1: 1 :length(niiFiles)
    fileFolder = string(niiFiles(fileIndex).folder);
    fileName = string(niiFiles(fileIndex).name);
    folderName = extractBetween(fileName, 1, strlength(fileName) -4);
    mkdir(folderName);
    % Read NIfTI Data and Header Info
    image = niftiread(fullfile(fileFolder, fileName));
    image_info = niftiinfo(fullfile(fileFolder, fileName));
    nifti_array = size(image);
    double = im2double(image);
    
    if length(nifti_array) ~= 3
        disp('Expected a 3D .nii File');
    else
        sliceCount = nifti_array(3); % NUMBER OF SLICES
        fprintf('\nConverting .nii file to .png file, please wait...\n');

        % from a previous analisys of the dataset whe found out that
        % the usefull bits of the tomography would be layers between the
        % 117th and 248th layer. To extract all layers the start is one (1)
        % and the end is sliceCount.
        start = 1;
        fprintf('  Extracting layers from %d to %d\n', start, sliceCount);
        for slice = start: 1 :sliceCount
            if lower(hasRotation) == 'y'
                if rotation == 90
                    data = rot90(mat2gray(double(:,:,slice)));
                elseif rotation == 180
                    data = rot90(rot90(mat2gray(double(:,:,slice))));
                elseif rotation == 270
                    data = rot90(rot90(rot90(mat2gray(double(:,:,slice)))));
                end
            elseif lower(ask_rotate) == 'n'
                data = mat2gray(double(:,:,slice));
            end
            
            %cropped = data(154:end, :);
            
            % Set Filename as per slice and vol info
            pngFileName = folderName + "_slice_" + ...
                sprintf('%03d', slice) + ".png";
            
            % Write Image
            imwrite(data, char(pngFileName));

            % Move Images To Folder
            movefile(char(pngFileName), folderName);

            progress = strcat('\n    Progress: ', ...
                num2str(slice/sliceCount*100), '%\n');

            if ((slice/sliceCount)*100) == 100
                fprintf('\nImages from %s were created!\n', fileName);
            else
                fprintf(progress);              
            end
        end
    end
end
fprintf('All files have been processed!\n');
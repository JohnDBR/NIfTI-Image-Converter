# NIfTI Image processor
To process a dataset of tomographies from patients with #COVID-19. 
In other to create a set of images to work with and analize its data
this algorithm was developed.

We used https://raw.githubusercontent.com/alexlaurence/NIfTI-Image-Converter/master/matlab/nii2png.m as reference.

## Environment
* Matlab 2020a

# Matlab Usage
1. Download de dataset from: https://www.kaggle.com/andrewmvd/covid19-ct-scans
2. Add the script to path and run it by typing: 
```
niiDataset2Png
```
3. Select your .nii files source folder.
4. Select the folder in which the images are going to be stored.
5. Rotate your image if you wish:
```
>> Would you like to rotate the orientation? (y/n)
>> y
>> OK. By 90° 180° or 270°? 
>> 90
```
5. Let it run.
6. Each .nii file is going to have its corresponding folder

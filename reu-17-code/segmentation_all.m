function [boundary_all, outer_boundary_all, maskCell, aver_thickness, area, cartilage, images_slices] = segmentation_all(n, type_bone)
% this function is used to run method on all MRI in the file. 
% @param n, number of previous points used to predict the next one (n = 4
% as my chosen value)
% @param bone_type: string input, either 'femur' or 'tibia'.

% @return boundary_all: cell that contains detected inner boundary of all images
% @return outer_boundary_all: cell contains detected outer boundary of all images
% @return imageCell: cell of original images
% @return maskCell: cell of images with detected boundary

% n = 4;

%set up directory of the file that contains images 
ImgDir = '/Users/NghiTram/Documents/Osteoarthritis/MRI_model';
imageType = '*.jpg'; % image type

% fullfile(ImgDir, imageType)
% get all filenames that match imageType
myFiles = dir(fullfile(ImgDir, imageType));

numImg = length(myFiles);

% preallocate container cells
imageCell = cell(1, numImg); %original image
maskCell = cell(1, numImg); % image with boundary detected. 

% contains detected inner and outer boundary of all images
boundary_all = cell(1, numImg);
outer_boundary_all = cell(1, numImg);

aver_thickness = cell(1, numImg);
area = cell(1, numImg);
cartilage = cell(1, numImg);

%read all the files listed in myFiles
close all 
for k = 1:numImg
   fileName = myFiles(k).name;
   fullFileName = fullfile(ImgDir, fileName);
    
   imageCell{k} = imread(fullFileName);
     
    
%  call the processing function
   [boundary_all{k}, outer_boundary_all{k}, maskCell{k}, aver_thickness{k}, area{k}, cartilage{k}] = main_script(fullFileName,n, type_bone);
end
images_slices = [];

for j = 1:numImg
holder = imageCell{j};
images_slices = cat(3, holder, images_slices);
end

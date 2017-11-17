function [bigBoundary, boundaries] = image_pre(img)
% @param img, image needed to pre-processing, e.g 'normal_knee.jpg'
% @return boundaries, matrix containing the inner boundary tracing values
% (value of the red line)
% @return bigBoundary, matrix containing the inner boundary tracing values
% (value of the blue line)

% input in color image.
rgbImage = imread(img);

figure(1);
set(gcf,'units','normalized','outerposition',[0 0 1 1])
title('Boundary Tracing of Cartilage');

imshow(rgbImage);

% convert image type
grayImage=rgb2gray(rgbImage);

% apply Gauss filter
grayImage = imgaussfilt(grayImage);

% find the thresholding value 
thresholdLevel=graythresh(grayImage);


hold on
drawnow;
hold on

% change to binary imgae
binaryImage = imbinarize(grayImage,thresholdLevel);

% Invert it and extract the largest blob.
binaryImage = bwareafilt(~binaryImage,3);

% removes from a binary image all connected
% components (objects) that have fewer than P pixels
binaryImage = bwareaopen(binaryImage, 40);

% extracts all connected components (objects)
%     from a binary image where the area is in RANGE (10 in our case)
binaryImage = bwareafilt(binaryImage, 10);

% Display the image.
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);


axis on;
hold on;

% remove all components with less than 1000 pixels
boundaries = bwboundaries(binaryImage);
for i = 1:length(boundaries)
    if length(boundaries{i}) < 1000
        boundaries{i} = [];
    end
end

%Display the boundary over the image 
visboundaries(boundaries, 'Color', 'r');
outer = imdilate(binaryImage, true(12));
bigBoundary = bwboundaries(outer);
% Display the boundary over the image.
visboundaries(bigBoundary, 'Color', 'b');
hold on 





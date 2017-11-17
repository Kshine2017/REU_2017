I = imread('normal_knee.jpg');
% I = imadjust(rgb2gray(I));
I = adapthisteq(rgb2gray(I));

[mOut] = ThresImage(I, 210);
I = bwareaopen(mOut, 10);
 I = bwareafilt(I, 5);
 I = bwareaopen(I, 20);
  I = bwareafilt(I, 5);
% area = bwarea(I);
% boundaries = bwboundaries(I);
binaryImage = I;
figure(3)
imshow(binaryImage)
[B,~,~,rgbImage] = bwboundaries(binaryImage);
% B = cell2mat(B);
boundaries = bwboundaries(binaryImage);
hold on 
visboundaries(boundaries, 'Color', 'r');
hold on 
bigMask = imdilate(binaryImage, true(12));
bigBoundary = bwboundaries(bigMask);
bigBoundary = cell2mat(bigBoundary);
hold on 
visboundaries(bigBoundary);

hold on 






% % I = imread('minor_knee.jpg');
% % I = imread('normal_knee.jpg');
% I = imread('gauss_filter.jpg');
% I = imadjust(rgb2gray(I));
% [mOut] = ThresImage(I, 215);
% I = bwareaopen(mOut, 10);
%  I = bwareafilt(I, 5);
%  I = bwareaopen(I, 20);
%   I = bwareafilt(I, 5);
% % area = bwarea(I);
% boundaries = bwboundaries(I);
% figure(3)
% imshow(I)
% hold on
% 
% visboundaries(boundaries, 'Color', 'r');
% hold on 





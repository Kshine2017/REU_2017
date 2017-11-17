%

% I = imread('test_knee.jpg');
% figure()
% imshow(I)

% %median filter 
% I0 = medfilt3(I);
% figure(4)
% imshow(I0)
% imwrite(I0, 'med_filter.jpg');
% 
% %Gaussian filter 
% I5 = imgaussfilt3(I);
% figure(5)
% imshow(I5)
% imwrite(I5, 'Gauss_filter.jpg');
% 
% back_ground = imopen(I,strel('disk',15));
% I2 = I- back_ground;
% figure(1)
% imshow(I2)
% imwrite(I2, 'clean_knee.jpg');

% 
% %Image constrast 
% A = double(im2bw(imread('test_knee.jpg')));
% I3 = imadjust((A));
% figure(2)
% imshow(I3)
% 
% %Threshold the image
% bw = imbinarize(A);
% bw = bwareaopen(bw,10);
% figure(3)
% imshow(bw)
% imwrite(bw, 'bw_knee.jpg');


% detecting cell
I6 = double(im2bw(imread('test_knee.jpg')));
figure(7)
imshow(I6)
[~, threshold] = edge(I6, 'sobel');
fudgeFactor = 0.5;
BWs = edge(I6, 'sobel', threshold*fudgeFactor);
figure(8), imshow(BWs);

%dilate the image
se90 = strel('line', 3,90);
se0 = strel('line', 3,0);
BWsdil = imdilate(BWs, [se90, se0]);
figure(9), imshow(BWsdil)

% Fill interior gap 
BWfill = imfill(BWsdil, 'holes');
figure(10), imshow(BWfill)

%remove connected objects on border 
BWnobord = imclearborder(BWfill, 4);
figure(11), imshow(BWnobord)

%smoothen the object
seD = strel('diamond',1);
BWfinal = imerode(BWnobord, seD);
BWfinal = imerode(BWfinal, seD);
figure(12)
imshow(BWfinal)

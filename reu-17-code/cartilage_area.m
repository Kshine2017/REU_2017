function [boundary, I] = cartilage_area(radius, center_x, center_y, I, mean_intensity)
%red pixel 
rgbImage = I;
% 
% figure();
% set(gcf,'units','normalized','outerposition',[0 0 1 1])

grayImage=rgb2gray(rgbImage);
thresholdLevel=graythresh(grayImage);


% set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);

% set(gcf, 'Name', 'Color Knee', 'NumberTitle', 'Off') 
% drawnow;
% hold on
% change to binary imgae
binaryImage = im2bw(grayImage,thresholdLevel);
% Invert it and extract the largest blob.
binaryImage = bwareafilt(~binaryImage,1);
% Fill Holes.
binaryImage = imfill(binaryImage, 'holes');
% Display the image.
% set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);

% axis on;
% hold on;
[B,~,~,rgbImage] = bwboundaries(binaryImage);
B = cell2mat(B);
% B = uint8(B);
% boundaries = bwboundaries(binaryImage);
% 
% % visboundaries(boundaries, 'Color', 'r');
% bigMask = imdilate(binaryImage, true(12));
% bigBoundary = bwboundaries(bigMask);
% % Display the boundary over the image.
% % visboundaries(bigBoundary);

figure()
set(gcf,'units','normalized','outerposition',[0 0 1 1])
imshow(I)
% 
% 
I(:,:,2) = 0; I(:,:,3) = 0;
% imshow(I)
boundary = [];
index = 1;
x_0 = center_x(index); y_0 = center_y(index);
k = radius;
theta = 0:5:250;
n = length(theta);

while n>0
    
    x_k = ceil(abs(x_0 + k*cosd(theta(index))));
    y_k = ceil(abs(y_0 + k*sind(theta(index))));
    
            hold on
            plot(center_x, center_y, '*r');
%             plot(x_k,y_k, '*g', 'MarkerSize',4);
             
            hold on
    if x_k >= size(I,1) || y_k >= size(I,2) || x_k < 5  || y_k <5
        
        index = index+1;
        k = radius-1;
        n = n-1;
        
    elseif I(x_k, y_k, 1) == 255 && I(x_k, y_k, 2) == 0 && I(x_k, y_k, 3) == 0
%       elseif I(x_k, y_k) ==1  
%     elseif ismember([x_k, y_k], B, 'rows') == 1
        
        [detection,k] = find_boundary(x_0, y_0,I,x_k, y_k, k , index);
        if detection == true
            disp('first change detected');
%             x_k = abs(384-x_k);
            boundary(index, 1)  = y_k;
            boundary(index,2) = x_k;
            hold on
            plot(y_k,x_k, '*b', 'MarkerSize',8);
            hold on
            index = index+1;
            k = radius-1;
            n = n-1;
        else
            k = k+0.5;
        end
    else
%         disp('elsecase');
        k = k+0.5;
        
    end
end
% hold on 
% plot(boundary(:,1), boundary(:,2), '*g', 'MarkerSize',4);
end

%         hold on
%
%         I = insertMarker(I,[x_k y_k],'*', 'color','red', 'size',3);
%         plot(x_k,y_k, '*r');
%         hold on
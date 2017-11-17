function [mean_intensity,center_x, center_y, radius, sd] = aver_intensity(img)

% number of region = 2; femur and tibia 
num_region = 1;

%read in and display image
img = imread(img);


figure(2)
set(gcf,'units','normalized','outerposition',[0 0 1 1])
title('Selecting ROI')
imshow(img);

% size of image 
size_image = size(img);

    
roi_count = 1;
while roi_count <= num_region
    str = ['Selecting region ', num2str(roi_count+1)]
    mess = sprintf('Use normal button right click to choose polyline and double click to end polyline selection');
    uiwait(msgbox(mess));
    data = imfreehand();
    xy = data.getPosition;
    
    %range of original image
    x_origin = [1, size_image(1)];
    y_origin = [1, size_image(2)];
    
    %range of the region (to make sure it won't go out of range of image)
    
      min_x = max(x_origin(1), min(xy(:,1)));
      max_x = min(x_origin(2), max(xy(:,1)));
      min_y = max(y_origin(1), min(xy(:,2)));
      max_y = min(y_origin(2), max(xy(:,2)));
      
      range_x = [min_x, max_x];
      range_y = [min_y, max_y];
%       plot(range_x, range_y, 'b');
%       text(range_x, range_y, num2str(roi_count), '12', 'Bold')
      
    roi = double(img(min_x:max_x, min_y:max_y));
    center_x(roi_count) =  [round(mean(xy(:,1)))];
    center_y(roi_count) = [round(mean(xy(:,2)))];
    % average intensity 
    
   mean_intensity(roi_count) = mean(roi(:));
   sd(roi_count) = std(roi(:));
%       plot(xy(:,1),xy(:,2),'b');
%       text(center_x(roi_count), center_y(roi_count), num2str(roi_count), 'b', '12','Bold');
%       [pixels_x, pixels_y] = meshgrid(xy(:,1), xy(:,2));
    
    roi_count = roi_count + 1;
    radius = min((max_x - min_x)/2, (max_y-min_y)/2);
   
end

 

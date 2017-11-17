function [boundary, outer_boundary, I, aver_thickness, area, cartilage]=  main_script(test_img, n, bone_type)
% @param training_img: name of the image, e.g 'normal_knee.jpg'
% @param n: number of previous points needed to predict the next point
% @param bone_type: string input, either 'femur' or 'tibia'.

%coeff_x and coeff_y were calculated for convenience, it can be computed by
%calling the function [coeff_x, coeff_y, X, Y] = linear_prediction(n,
%training_img).
load coeff_x
load coeff_y 

bone_type = lower(bone_type);
if strcmp(bone_type, 'femur') ~= 1 && strcmp(bone_type, 'tibia') ~= 1
    disp('Invalid type_bone input')
    error('please check input')
end 
% % pre-processing the image 
[bigBoundary, boundaries] = image_pre(test_img);

% get average intensity, center, and radius to start detecting the cartilage
% click on the image to start drawing the ROI.
[mean_intensity,center_x, center_y, radius, sd] = aver_intensity(test_img);
% detecting inner and outer boundaries of the cartilage
if strcmp(bone_type, 'femur') == 1
[boundary, outer_boundary, I] = cartilage_area2(radius, center_x, center_y, test_img, mean_intensity, sd, boundaries, bigBoundary,coeff_x, coeff_y,n);
elseif strcmp(bone_type, 'tibia') == 1
    [boundary, outer_boundary, I] = cartilage_tibia(radius, center_x, center_y, test_img, mean_intensity, sd, boundaries, bigBoundary,coeff_x, coeff_y,n);  
end 
% thickness calculation
[aver_thickness] = thickness_calculation(boundary, outer_boundary);
% segment the cartiage and area calculation
[area, cartilage] = segmentation_area(boundary, outer_boundary, test_img);
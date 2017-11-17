function [coeff_x, coeff_y, X, Y] = linear_prediction(n, training_img)
% @param n: number of previous points (n = 4 in as my chosen value)
% @param training_img: image used to create a vector of training set
% (usually the normal knee image)
% @return coeff_x, coeff_y: vectors of coefficients used to predict the (x,y)-coordinate of next inner
% boundary value

% creating a training set for linear regression model
% pre-processing the image 
[bigBoundary, boundaries] = image_pre(training_img);
close all;
% get average intensity, center, and radius to start detecting the cartilage

% CLICK ON IMAGE TO START DRAWING ROI. 
[mean_intensity,center_x, center_y, radius, sd] = aver_intensity(training_img);
 close all;
% detecting inner and outer boundaries of the cartilage 
[boundary] = training_boundary(radius, center_x, center_y, training_img, mean_intensity, sd, boundaries, bigBoundary);


%CALCULATING THE COEFFICIENTS 
%creating a matrix X of length n sequences
X = [];
Y = [];
boundary( ~any(boundary,2), : ) = []; boundary( :, ~any(boundary,1) ) = [];
for i = 1:length(boundary) - n 
    X(i,:) = boundary(i:i+n,1);
    Y(i,:) = boundary(i:i+n,2);
end 


b = X(:, end); X(:, end) = []; 
c = Y(:, end); Y(:, end) = [];
coeff_x = inv(X'*X)*X'*b; coeff_x = coeff_x';
coeff_y = inv(Y'*Y)*Y'*c; coeff_y = coeff_y';



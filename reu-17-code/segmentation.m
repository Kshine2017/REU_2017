function segmentation
I = imread('normal_knee.jpg');
mask = zeros(size(I));
for elem = boundary
    mask(elem) = 1;
end 

mask(boundary(:,1), boundary(:,2)) = 1;
mask(outer_boundary(:,1), outer_boundary(:,2)) = 1;
bw = activecontour(I,mask,300);
figure()
imshow(bw)
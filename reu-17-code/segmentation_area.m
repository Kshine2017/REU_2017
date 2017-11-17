function [area, new] = segmentation_area(inner_boundary, outer_boundary, I)

I = imread(I);
[rows, columns, numberOfColorChannels] = size(I);
new = zeros(rows, columns);
new = 0*I;
x1 = inner_boundary(:,1);
y1 = inner_boundary(:,2);
x2 = outer_boundary(:,1);
y2 = outer_boundary(:,2);
mask = poly2mask( x1, x2, rows, columns);
mask1 = poly2mask( y1, y2, rows, columns);

mask(mask ==1) = 0;
mask1(mask1 == 1) = 0;
figure(4)

hold on
imshow(mask)
hold on
imshow(mask1)
hold on
for i = 1:length(x1)-2
    if abs(x1(i) - x1(i+2)) < 40 && abs(x2(i) - x2(i+2)) < 40
        hold on
        new = insertShape(new,'Line',[x1(i), y1(i), x1(i+1), y1(i+1)],'LineWidth',3,'Color','w');
        new = insertShape(new,'Line',[x2(i), y2(i), x2(i+1), y2(i+1)],'LineWidth',3,'Color','w');       
        hold on
        new = insertShape(new,'Line',[x1(end-1), y1(end-1),x2(end-1), y2(end-1)],'LineWidth',3,'Color','w');
        new = insertShape(new,'Line',[x1(1), y1(1),x2(1), y2(1)],'LineWidth',3,'Color','w');
        plot(x1(i:i+2),y1(i:i+2),x2(i:i+2), y2(i:i+2),'LineWidth',3,'Color','w')
    
    end 
end 
hold on 


line([x1(end), x2(end)], [y1(end), y2(end)], 'LineWidth', 2, 'Color', 'w');
line([x1(1), x2(1)], [y1(1), y2(1)], 'LineWidth', 2, 'Color', 'w');

new = rgb2gray(new);
new = imfill(new, 'holes');

% calculating area 
area = bwarea(new);


x = 70:5:350;
y = 100:5:250;


%# plot
hold on
clr = lines(6);
h = zeros(6,1);
for i=1:5
    h(i) = plot(boundary_all{i}(:,1), boundary_all{i}(:,2), 'Color',clr(i,:), 'LineWidth',2);
    set(h(i), 'ZData',ones(size(boundary_all{i}(:,1)))*i)
end

zlim([0 6]), box on, grid on
view(3)

hold on 
for i=1:5
    h(i) = plot(outer_boundary_all{i}(:,1), outer_boundary_all{i}(:,2), 'Color',clr(i,:), 'LineWidth',2);
    set(h(i), 'ZData',ones(size(outer_boundary_all{i}(:,1)))*i)
end
zlim([0 6]), box on, grid on
view(3)
hold off


x1 = boundary(:,1);
y1 = boundary(:,2);
x2 = outer_boundary(:,1);
y2 = outer_boundary(:,2);
figure()
hold on 
imshow(I)
hold on 
plot(x1(end), y1(end), '*c')
hold on 
plot(x2(end), y2(end), '*y')
hold on 
plot(x1(1), y1(1), '*w')
hold on 
plot(x2(1), y2(1), '*m')
hold on 

plot([y1(end), x1(end)], [y2(end),x2(end)])
plot([y1(end), x1(end)], [y2(end),x2(end)],'LineWidth',1,'Color','m');
plot([x1(1), y1(1)], [x2(1), y2(1)])


x = boundary_all{1}(:,1);
y = polyval(p,x);

xx = 70:5:300;
% cs = spline(x,y,xx);

yy = spline(x,y,xx);
plot(x,y,'o',xx,yy) 


I = imread('normal_knee.jpg');

[rows, columns, numberOfColorChannels] = size(I);
% new = zeros(rows, columns);
new = 0*I;
x1 = boundary(:,1);
y1 = boundary(:,2);
x2 = outer_boundary(:,1);
y2 = outer_boundary(:,2);
mask = poly2mask( x1, x2, rows, columns);
mask1 = poly2mask( y1, y2, rows, columns);

mask(mask ==1) = 0;
mask1(mask1 == 1) = 0;

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



plot(x1(end), y1(end), '*g',x2(end), y2(end), '*r')
plot(x1(1), y1(1), '*b')
plot(x2(1), y2(1), '*m')

for m = min(min(boundary(:,1),min(outer_boundary(:,1)))):max(max(boundary(:,1),max(outer_boundary(:,1))))
      for n =  min(min(boundary(:,2),min(outer_boundary(:,2)))):max(max(boundary(:,2),max(outer_boundary(:,2))))
          for i = 1:size(boundary)
            if x1(i) < m<x2(i) && y1(i) <n<y2(i)
                hold on 
              mask(m,n) = 1;
            end
          end
      end
  end
hold on 
imfill(mask, [x1,y1],'holes')
hold on 
imfill(mask, [x2, y2], 'holes')
hold off
%
I = imread('normal_knee.jpg');
c = boundary(:,1);
r = boundary(:,2);
BW = roipoly(I,c,r);
a = outer_boundary(:,1);
b = outer_boundary(:,2);
BW1 = roipoly(I, a, b);
hold on
imshow(I)
hold on
 imshow(BW)
 hold on
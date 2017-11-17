function [boundary, outer_boundary, I] = cartilage_area2(radius, center_x, center_y, I, mean_intensity, sd, boundaries, bigBoundary, coeff_x, coeff_y,s)


I = imread(I);
A = I;
% convert cell to double
bigBoundary = cell2mat(bigBoundary);
boundaries = cell2mat(boundaries);

figure(3)
set(gcf,'units','normalized','outerposition',[0 0 1 1])
title('Detecting the Cartilage Boundary')
imshow(I)

boundary = [];
outer_boundary = [];
index = 1;
x_0 = center_y(index); y_0 = center_x(index);
k = radius;
theta = 0:5:360;
% theta = 200:5:340;
i = 1;
n = length(theta);
terminate = false;
boolean = false;
while n>0 && terminate == false
    
    x_k = ceil(abs(y_0 + k*cosd(theta(index))));
    y_k = ceil(abs(x_0 + k*sind(theta(index))));    
    hold on
    plot(y_0, x_0, '*r');
    I = insertMarker(I,[y_0 x_0],'*', 'color','red', 'size',3);
%     plot(x_k,y_k, '*m', 'MarkerSize',4);
    
    hold on
    
       if ismember([y_k, x_k], boundaries, 'rows') == 1
            boolean = true;
       elseif ismember([y_k+1, x_k+1], boundaries, 'rows') == 1
            boolean = true;
       elseif ismember([y_k, x_k+1], boundaries, 'rows') == 1
            boolean = true;
       elseif ismember([y_k+1, x_k], boundaries, 'rows') == 1
            boolean = true;
       elseif ismember([y_k-1, x_k-1], boundaries, 'rows') == 1
            boolean = true;
       elseif ismember([y_k, x_k-1], boundaries, 'rows') == 1
            boolean = true;
       elseif ismember([y_k-1, x_k], boundaries, 'rows') == 1
            boolean = true;
       else
            boolean = false;
    end
    if x_k >= size(I,1) || y_k >= size(I,2) || x_k < 5  || y_k <5
        
        index = index+1;
        k = radius-1;
        n = n-1;
        
    elseif boolean == true  
        
        disp('change detected');
        
     
        if y_k > 100
            boundary( ~any(boundary,2), : ) = []; boundary( :, ~any(boundary,1) ) = [];
            outer_boundary( ~any(outer_boundary,2), : ) = []; outer_boundary( :, ~any(outer_boundary,1) ) = [];
            
            %           check for break point
            if size(boundary,1) >= s
                x_predicted = floor(abs(sum(coeff_x.*boundary(i:i+s-1,1)')));
                y_predicted = floor(abs(sum(coeff_y.*boundary(i:i+s-1,2)')));
                i = i+1;
                if (abs(x_predicted - x_k) > 5 ) || (abs(y_predicted - y_k) > 5)
                    disp('breakpoint detected')
%                     plot(x_predicted, y_predicted, '*g', 'MarkerSize', 5);
                    I = insertMarker(I,[x_k y_k],'*', 'color','blue', 'size',1);
%                     plot(x_k, y_k, '*m', 'MarkerSize', 3);
                    terminate = true;
                    break;
                else
                    boundary(index, 1)  = x_k;
                    boundary(index,2) = y_k;
                    hold on
                    plot(x_k,y_k, '*b', 'MarkerSize',5);
                    I = insertMarker(I,[x_k y_k],'*', 'color','blue', 'size',1);
                    hold on
                    k = k+6;
                end
            else
                boundary(index, 1)  = x_k;
                boundary(index,2) = y_k;
                hold on
                plot(x_k,y_k, '*b', 'MarkerSize',5);
                I = insertMarker(I,[x_k y_k],'*', 'color','blue', 'size',1);                
                hold on
                k = k+6;
        end 
            
            
            while x_k < size(I,1) && y_k < size(I,2) && x_k > 5  && y_k > 5 && terminate ~= true
                x_k = floor(abs(y_0 + k*cosd(theta(index))));
                y_k = floor(abs(x_0 + k*sind(theta(index))));
                change = abs(I(x_k, y_k) - (floor(mean_intensity)+sd/2));
                if ismember([y_k, x_k], boundaries, 'rows') == 1 || ismember([y_k, x_k], bigBoundary, 'rows') == 1 || change < (floor(mean_intensity))
                    disp('outer boundary point detected')
                    if y_k >100
                        outer_boundary(index,1) = x_k;
                        outer_boundary(index,2) = y_k;
                        hold on
                        plot(x_k,y_k, '*g', 'MarkerSize',5);
                        I = insertMarker(I,[x_k y_k],'*', 'color','green', 'size',1);                        
                        hold on
                    end
                    break
                else
                    k = k+0.5;
                end
            end
            
            index = index+1;
            k = radius-1;
            n = n-1;
        else
            index = index+1;
            k = radius-1;
            n = n-1;
        end
    else
        k = k+0.5;
        
    end
end
boundary( ~any(boundary,2), : ) = []; boundary( :, ~any(boundary,1) ) = [];
outer_boundary( ~any(outer_boundary,2), : ) = [];
outer_boundary( :, ~any(outer_boundary,1) ) = [];

if size(boundary,1) > size(outer_boundary,1) 
    diff =  size(boundary,1) - size(outer_boundary,1);
    for j = 1:diff 
        boundary(end,:) = [];
    end
elseif size(boundary,1) < size(outer_boundary,1)
        diff = size(outer_boundary,1) - size(boundary,1);
    for j = 1:diff 
        outer_boundary(end,:) = [];
    end
end 
x1 = boundary(:,1);
y1 = boundary(:,2);
x2 = outer_boundary(:,1);
y2 = outer_boundary(:,2);
hold on
for i = 1:length(x1)-2
    if abs(x1(i) - x1(i+1)) < 40 && abs(x2(i) - x2(i+1)) < 40
        hold on 
       I = insertShape(I,'Line',[x1(i), y1(i), x1(i+1), y1(i+1)],'LineWidth',1,'Color','blue');
       I = insertShape(I,'Line',[x2(i), y2(i), x2(i+1), y2(i+1)],'LineWidth',1,'Color','blue');
       plot(x1(i:i+2),y1(i:i+2),x2(i:i+2), y2(i:i+2),'LineWidth',1,'Color','w')
        hold on
    end
end



end


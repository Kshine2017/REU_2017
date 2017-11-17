function [boundary, outer_boundary, I] = cartilage_area3(radius, center_x, center_y, I, mean_intensity, sd, boundaries, bigBoundary)
% change in pixel 
figure()
set(gcf,'units','normalized','outerposition',[0 0 1 1])

imshow(I)

boundary = [];
outer_boundary = [];
index = 1;
x_0 = center_x(index); y_0 = center_y(index);
% y_0 = center_x(index); x_0 = center_y(index);
k = radius;
theta = 0:5:360;
n = length(theta);
while n>0
    
    x_k = floor(abs(x_0 + k*cosd(theta(index))));
    y_k = floor(abs(y_0 + k*sind(theta(index))));
    change = abs(I(x_k, y_k) - floor(mean_intensity));
%     change = abs(I(x_k, y_k));
            hold on
          plot(x_0,y_0, '*r', 'MarkerSize',4);
%           plot(x_k, y_k, '*m', 'MarkerSize',4);
            hold on
    if x_k >= size(I,1) || y_k >= size(I,2) || x_k <5  || y_k <5
        
        index = index+1;
        k = radius-1;
        n = n-1;
        
    elseif (x_k ~= size(I,1) && y_k ~= size(I,2)) && (change > (floor(mean_intensity)+sd))
%     elseif I(x_k,y_k) == 1
%         [detection,k] = find_boundary1(x_0, y_0,I,x_k, y_k, k , index);
%         if detection == true
            disp('change detected');
            if x_k > 100
            boundary(index, 1)  = y_k;
            boundary(index,2) = x_k;
            hold on
            plot(y_k,x_k, '*b', 'MarkerSize',6);
%             plot(x_k,y_k, '*b', 'MarkerSize',6);
            hold on
            
            k = k+2;
            end
            while x_k < size(I,1) && y_k < size(I,2) && x_k > 5  && y_k > 5
                    x_k = floor(abs(x_0 + k*cosd(theta(index))));
                    y_k = floor(abs(y_0 + k*sind(theta(index))));
                    change = abs(I(x_k, y_k) - floor(mean_intensity));
%                       change = abs(I(x_k, y_k) - floor(mean_intensity));
                    if change < (floor(mean_intensity))
                        disp('outer boundary point detected')
                        if x_k >100 
                        outer_boundary(index,1) = y_k;
                        outer_boundary(index,2) = x_k;
                        hold on
                        plot(y_k,x_k, '*g', 'MarkerSize',6);
%                         plot(x_k,y_k, '*g', 'MarkerSize',6);
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
% 
%             
%         else
%             k = k-0.5;
%             x_k = floor(abs(x_0 + k*cosd(theta(index))));
%             y_k = floor(abs(y_0 + k*sind(theta(index))));
%         end
    else
        k = k+0.5;
        
    end
end
end


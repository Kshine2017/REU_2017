function [boundary, outer_boundary] = training_boundary(radius, center_x, center_y, img, mean_intensity, sd, boundaries, bigBoundary)

I = imread(img);
% convert cell to double
bigBoundary = cell2mat(bigBoundary);
boundaries = cell2mat(boundaries);

figure(8)
set(gcf,'units','normalized','outerposition',[0 0 1 1])
imshow(I)

boundary = [];
outer_boundary = [];
index = 1;
x_0 = center_y(index); y_0 = center_x(index);
k = radius;
theta = 0:5:360;

n = length(theta);
i=1; s = 4;
terminate = false;
while n>0 && terminate == false
    
    x_k = ceil(abs(y_0 + k*cosd(theta(index))));
    y_k = ceil(abs(x_0 + k*sind(theta(index))));
    
    hold on
    plot(y_0, x_0, '*r');
    hold on
    if x_k >= size(I,1) || y_k >= size(I,2) || x_k < 5  || y_k <5
        
        index = index+1;
        k = radius-1;
        n = n-1;
        
    elseif ismember([y_k, x_k], boundaries, 'rows') == 1
        disp('change detected');
        
        if y_k > 100
            
            boundary(index, 1)  = x_k;
            boundary(index,2) = y_k;
            hold on
            plot(x_k,y_k, '*b', 'MarkerSize',2);
            hold on
            k = k+6;
            
            
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
                        plot(x_k,y_k, '*g', 'MarkerSize',2);
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

end


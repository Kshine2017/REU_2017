function [boundary] = cartilage_area1(radius, center_x, center_y, I, mean_intensity)
figure()
set(gcf,'units','normalized','outerposition',[0 0 1 1])

imshow(I)

boundary = [];
index = 1;
x_0 = center_x(index); y_0 = center_y(index);
k = radius;
theta = 0:5:255;
n = length(theta);
time = 1;
while n>0
    
    x_k = floor(abs(x_0 + k*cosd(theta(index))));
    y_k = floor(abs(y_0 + k*sind(theta(index))));
    change = abs(I(x_k, y_k) - floor(mean_intensity));
    
            hold on
            plot(x_k,y_k, '*g', 'MarkerSize',8);
            hold on
    if x_k >= size(I,1) || y_k >= size(I,2) || x_k <5  || y_k <5
        
        index = index+1;
        k = radius-1;
        n = n-1;
        
%     elseif (x_k ~= size(I,1) && y_k ~= size(I,2)) && (change < floor(mean_intensity))
    elseif (x_k ~= size(I,1) && y_k ~= size(I,2)) && (change >100)    
        [detection,k] = find_boundary(x_0, y_0,I,x_k, y_k, k , index);
        if detection == true
            disp('first change detected');
            boundary(index, 1)  = x_k;
            boundary(index,2) = y_k;
            hold on
            plot(x_k,y_k, '*b', 'MarkerSize',8);
            hold on
            
            x_k = floor(abs(x_0 + k*cosd(theta(index))));
            y_k = floor(abs(y_0 + k*sind(theta(index))));
            
            while x_k < size(I,1) && y_k < size(I,2) && x_k >5  && y_k >5 && time <2 
                disp('computing detection');
                [detection, k] = find_boundary(x_0, y_0,I,x_k, y_k, k,index)
                disp('finishing detection');
                if (change < (I(x_k, y_k) - floor(mean_intensity))) && (detection == true)
                    disp('checking');
                    boundary(index, 1)  = x_k;
                    boundary(index,2) = y_k;
                    hold on
                    plot(x_k,y_k, '*r', 'MarkerSize',8);
                    hold on
                    time = 2;
                    change = I(x_k, y_k) - floor(mean_intensity);
                    x_k = floor(abs(x_0 + k*cosd(theta(index))));
                    y_k = floor(abs(y_0 + k*sind(theta(index))));
                else
                    disp('passing');
                    if detection == true
                        k = k -1.5;
                    else
                        k = k;
                    end 
                    x_k = floor(abs(x_0 + k*cosd(theta(index))));
                    y_k = floor(abs(y_0 + k*sind(theta(index))));
                end
            end
        else
            k = k-1;
        end
    else
        disp('elsecase');
        k = k+0.5;
        
    end
end
end

%         hold on
%
%         %  I = insertMarker(I,[x_k y_k],'*', 'color','red', 'size',3);
%         plot(x_k,y_k, '*r');
%         hold on

% function [boundary, I] = cartilage_area(radius, center_x, center_y, I, mean_intensity)
% 
% %input in format: imread('color_knee1.jpg')
% I = I(:,:,1);
% boundary = [];
% index = 1;
% x_0 = center_x(index); y_0 = center_y(index);
% k = radius;
% theta = 0:5:200;
% n = length(theta);
% 
% while n>0
%     
%     x_k = floor(abs(x_0 + k*cosd(theta(index))));
%     y_k = floor(abs(y_0 + k*sind(theta(index))));
%     
%             hold on
%             plot(center_x, center_y, '*r');
% %             plot(187,112, '*g', 'MarkerSize',8);
%              
%             hold on
%     if x_k >= size(I,1) || y_k >= size(I,2) || x_k < 5  || y_k <5
%         
%         index = index+1;
%         k = radius-1;
%         n = n-1;
%         
%     elseif I(x_k, y_k) == 255
%         
%         [detection,k] = find_boundary(x_0, y_0,I,x_k, y_k, k , index);
%         if detection == true
%             disp('first change detected');
%             boundary(index, 1)  = x_k;
%             boundary(index,2) = y_k;
%             hold on
%             plot(x_k,y_k, '*b', 'MarkerSize',8);
%             hold on
%             index = index+1;
%             k = radius-1;
%             n = n-1;
%         else
%             k = k+0.5;
%         end
%     else
% %         disp('elsecase');
%         k = k+1;
%         
%     end
% end
% end
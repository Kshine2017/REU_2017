function [aver_thickness] = thickness_calculation(x, y)
%@param x, vector of inner boundary values
%@param y, vector of outer boundary values 
%@return aver_thickness, the average thickness of cartialge 

%FACTOR (used to convert unit from pixel to mm)
factor = 15/1182;
thickness = zeros(size(x,1),1);
if isequal(size(x), size(y)) == 1
    for i = 1:size(x,1)
        thickness(i) = sqrt((x(i,1) - y(i,1))^2 + (x(i,2) - y(i,2))^2);
    end
else 
    disp('x and y have to have the same size')
    return 
end 
    aver_thickness = mean(thickness)*factor*10;
% classification (only take into account the femur bone)

  if aver_thickness < 2 && aver_thickness >= 0.6
        disp('normal')
    elseif (aver_thickness < 0.6 )
       disp('affected')
    else 
        disp('doubtful')
end
end 
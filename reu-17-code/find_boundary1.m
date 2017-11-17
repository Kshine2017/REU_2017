function [detection,k] = find_boundary(x_0, y_0,I,x_k, y_k, k , index)

size_I = size(I,1);
theta = 0:5:255;
k = k+0.5;
x_k1 = floor(abs(x_0 + k*cosd(theta(index))));
y_k1 = floor(abs(y_0 + k*sind(theta(index))));
count = 2;
while count > 0
    if x_k1 >= size_I || y_k1 >= size_I || x_k1 <4 || y_k1 <4
        detection = false;
        break;
    elseif abs(I(x_k1, y_k1) - I(x_k, y_k)) < 5
%     elseif abs(I(x_k1, y_k1) - I(x_k, y_k)) == 1
        count = count -1;
        k = k+0.5;
        x_k1 = floor(abs(x_0 + k*cosd(theta(index))));
        y_k1 = floor(abs(y_0 + k*sind(theta(index))));
        if count == 0
            detection = true;
        end
    else
        detection = false;
        k = k+0.5;
        break;
    end
end


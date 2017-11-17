%  I = imread('color_knee_r.jpg');
%  imshow(I)
%  I = imcrop(I);
%  imwrite(I, 'knee.jpg');
 red_pixel1 = [];
for m = 1:size(I2,1)
      for n = 1:size(I2,2)
          if I2(m,n,1) == 255 && I2(m,n,2) == 0 && I2(m,n,3) == 0
              red_pixel1(m,n) = 1;
          end
      end
end

%   A = I(:,:,1); 
% for m = 1:size(A,1)
%     for n = 1:size(A,2)
%         if A(m,n) == 255 
%             red(m,n) = 1;
%         end 
%     end
% end
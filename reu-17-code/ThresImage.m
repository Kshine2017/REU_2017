function [mOut] = ThresImage(fname, threshold)

cellimage = imread(fname);
cellimage = fname;
MAX = (max(max(double(cellimage))));
MIN = min(min(double(cellimage)));

if nargin ==1;
    threshold = round((MAX+ MIN)/2);
end


convert = double(cellimage(:,:,1));
figure();
set(gcf,'units','normalized','outerposition',[0 0 1 1])
imshow(cellimage);

a = find(convert < threshold(:,:,1));
      convert(a) = 0;
    b = find(convert >= threshold(:,:,1));
      convert(b) = 255;
      
      mOut = uint8(convert);
      figure;
      imshow(mOut);
end

      
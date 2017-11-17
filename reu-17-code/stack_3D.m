function stack_3D 

for i=139:141
    % {} = cell array
  images{i} = imread(sprintf('IMG_%d.JPG',i));
end
myImage = cat(3,I{139:141});
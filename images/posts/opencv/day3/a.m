img = imread('hyd.jpg');
imshow(img);

noise = randn(size(img)) .* 50;
output = img + noise;
imshow(output);
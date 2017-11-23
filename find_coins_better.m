% function  [] = find_coins_better(image_color)

image_original = imread('coins8.jpg');
[row, col, page] = size(image_original) ;
image_original=imresize(image_original,[1040,780]); 

image_gray = rgb2gray(image_original);
image_normalised =double(image_gray)/255;
figure
subplot(2,5,1);
imshow(image_normalised);

threshold = graythresh(image_normalised);
image_BW =im2bw(image_normalised, threshold);
subplot(2,5,2);
imshow(image_BW);

image_BW_invert= 1-image_BW;
image_fill = imfill(image_BW_invert,'holes');
image_BW=1-image_fill;

[image_result, area, perimeter ] = loop_erode_dialate(image_BW,2,10,5,0.2);
[image_result, area, perimeter ] = loop_erode_dialate(image_result,3,14,10,0.05);

circularity = (perimeter .^ 2) ./ (4 * pi * area);


% end
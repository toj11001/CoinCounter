function[coins_area, number ,coins_cent] = find_number_coins(image_color)

image_gray = rgb2gray(image_color);
image_normalised =double(image_gray)/255;
subplot(2,5,3);
imshow(image_normalised);

subplot(2,5,4);

threshold = graythresh(image_normalised);
image_BW =im2bw(image_normalised, threshold);

imshow(image_BW);

image_BW_invert= 1-image_BW;
image_fill = imfill(image_BW_invert,'holes');
image_BW=1-image_fill;

r1 = 7;
r2 = 55;
r3 = 20;
se1 = strel('disk',r1,0);
se2 = strel('disk',r2,0);
se3 = strel('disk',r3,0);

image_erode_1=imerode(image_BW,se1);
subplot(2,5,5);
imshow(image_erode_1);  

image_dialate_1=imdilate(image_erode_1,se2);

subplot(2,5,6);
imshow(image_dialate_1);
image_erode_2 =imerode(image_dialate_1,se3);
 subplot(2,5,7);
 imshow(image_erode_2);

image_thresh = bwpropfilt(im2bw(1-image_erode_2),'Area',[0 20000]);

image_cc = bwconncomp(image_thresh);


image_labeled = labelmatrix(image_cc);

image_RGB_label = label2rgb(image_labeled);
subplot(2,5,8);
imshow(image_RGB_label);

coins_area = regionprops(image_labeled,'Area');
coins_cent = regionprops(image_labeled,'Centroid');
coins_cent = cat(1,coins_cent.Centroid);

number = length(cell2mat(squeeze(struct2cell(coins_area))));

end
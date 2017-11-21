function [number_of_5cents, area_of_coin] = find_5cent(image_color)

image_mask = createMask(image_color);
subplot(2,5,9);
imshow(image_mask);
image_hole_fill = imfill(image_mask,'holes');

subplot(2,5,9);
imshow(image_hole_fill);

image_invert = 1-image_hole_fill;
area_of_coin = sum(image_invert(:) == 0);
    
r1 = 1;
r2 = 15;
r3 = 2;

    
se1 = strel('disk',r1,0);
se2 = strel('disk',r2,0);
se3 = strel('disk',r3,0);

image_erode_1 =imerode(image_invert,se1);
% figure
% imshow(image_erode_1);

image_dialate_1=imdilate(image_erode_1,se2);
% figure
% imshow(image_dialate_1);
image_erode_2 =imerode(image_dialate_1,se1);
image_cc = bwconncomp(1-image_erode_2);
image_labeled = labelmatrix(image_cc);
image_RGB_label = label2rgb(image_labeled);

subplot(2,5,1);
imshow(image_RGB_label);
image_5cent_count = regionprops(image_labeled,'Area');
number_of_5cents = length(image_5cent_count);
% if number_of_5cents==1
%     area_of_coin = cell2mat(squeeze(struct2cell(image_5cent_count)));
% else
%     area_of_coin = mean(cell2mat(squeeze(struct2cell(image_5cent_count))));
  
%end
end
function [image_5cent_centroid, number_of_5cents] = find_5cent(image_color)

%figure('units','normalized','outerposition',[0 0 1 1])
image_mask = createMask(image_color);
% subplot(2,5,1);
%imshow(image_mask);
image_hole_fill = imfill(image_mask,'holes');

% subplot(2,5,2);
%imshow(image_hole_fill);

image_invert = 1-image_hole_fill;
area_of_coin = sum(image_invert(:) == 0);
 
[image_result, area, perimeter ] = loop_erode_dialate(image_invert,2,10,5,0.2,5);


image_cc = bwconncomp(1-image_result);
image_labeled = labelmatrix(image_cc);
image_RGB_label = label2rgb(image_labeled);

% figure
% imshow(image_RGB_label);

image_5cent_centroid = regionprops(image_labeled,'Centroid');
number_of_5cents = length(image_5cent_centroid);


end
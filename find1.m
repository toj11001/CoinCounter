function [image1_centroid, number_of_1] = find1(image_color)

image_BW = createMaskS(image_color);
image_fill = imfill(image_BW,'holes');
image_BW=1-image_fill;

[image_result_t, area, perimeter ] = loop_erode_dialate(image_BW,2,10,2,0.2,0);
image_mul = 1-immultiply(1-image_result_t,1-image_result_t);
% figure
% imshow(image_mul);
image_cc = bwconncomp(1-image_mul);
image_labeled = labelmatrix(image_cc);
image1_centroid = regionprops(image_labeled,'Centroid');
number_of_1 = length(image1_centroid);
end
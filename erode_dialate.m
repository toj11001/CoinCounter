function [image_erode_dialate ,coins_area, coins_perimeter] = erode_dialate(image_input, erode1, dialate1, erode2)
se1 = strel('disk',erode1,0);
se2 = strel('disk',dialate1,0);
se3 = strel('disk',erode2,0);

image_erode_1=imerode(image_input,se1);
image_dialate_1=imdilate(image_erode_1,se2);
image_erode_dialate =imerode(image_dialate_1,se3);

subplot(2,5,3);
imshow(image_erode_dialate);

image_cc = bwconncomp(1-image_erode_dialate);
image_labeled = labelmatrix(image_cc);
coins_area = cell2mat(squeeze(struct2cell(regionprops(image_labeled,'Area'))));
coins_perimeter =cell2mat(squeeze(struct2cell(regionprops(image_labeled,'Perimeter'))));
end
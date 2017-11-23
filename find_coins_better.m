% function  [] = find_coins_better(image_color)

image_original = imread('coins4.jpg');
[row, col, page] = size(image_original) ;
image_original=imresize(image_original,[1040,780]); 

image_gray = rgb2gray(image_original);
image_normalised =double(image_gray)/255;

threshold = graythresh(image_normalised);
image_BW =im2bw(image_normalised, threshold);

image_BW_invert= 1-image_BW;
image_fill = imfill(image_BW_invert,'holes');
image_BW=1-image_fill;

[image_result, area, perimeter ] = loop_erode_dialate(image_BW,2,10,5,0.2,0);
[image_result, area, perimeter ] = loop_erode_dialate(image_result,3,14,10,0.05,0);

circularity = (perimeter .^ 2) ./ (4 * pi * area);

image_cc = bwconncomp(1-image_result);
image_labeled = labelmatrix(image_cc);
image_RGB_label = label2rgb(image_labeled);

%figure('units','normalized','outerposition',[0 0 1 1])

number_coins = length(area);
disp("the total number of coins is ");
disp(number_coins);

coins_cent =((regionprops(image_labeled,'Centroid')));
coins_cent = cat(1,coins_cent.Centroid);

[image_5cents_centroid, number_5cent] = find_5cent(image_original);
coins_5cent_cent = cat(1,image_5cents_centroid.Centroid);

 coin_5cent_loc = [1];

for i=1:1:number_5cent

for j=1:1:number_coins
if abs(coins_5cent_cent(i,1)-coins_cent(j,1)) <5 && abs(coins_5cent_cent(i,2)-coins_cent(j,2)) <5
coin_5cent_loc(i) = j; 
end
end
end

coin_5cent_avg_area =0;
for i=1:1:number_5cent
    coin_5cent_avg_area = coin_5cent_avg_area+ (area(coin_5cent_loc(i)));
    area(coin_5cent_loc(i)) = 0;
    
end
coin_5cent_avg_area = coin_5cent_avg_area/number_5cent;


figure('units','normalized','outerposition',[0 0 1 1])
subplot(1,2,2);
imshow(image_RGB_label);
ratio = area/coin_5cent_avg_area;
for counter = 1:1: number_coins
    
    
if (ratio(counter) >1.5) & (ratio(counter)<1.6)
       image_original = insertText(image_original,coins_cent(counter,:),num2str(2),'FontSize',24);
end
if (ratio(counter) >1.25) & (ratio(counter)<1.35)
       image_original = insertText(image_original,coins_cent(counter,:),num2str(0.5),'FontSize',24);
end
if (ratio(counter) >0.75) & (ratio(counter)<0.85)
       image_original = insertText(image_original,coins_cent(counter,:),num2str(0.1),'FontSize',24);
end
if (ratio(counter) >0.95) & (ratio(counter)<1.1)
       image_original = insertText(image_original,coins_cent(counter,:),num2str(0.2),'FontSize',24);
end
if (ratio(counter) >1.1) & (ratio(counter)<1.2)
       image_original = insertText(image_original,coins_cent(counter,:),num2str(1),'FontSize',24);
end

if (ratio(counter) == 0)
       image_original = insertText(image_original,coins_cent(counter,:),num2str(0.05),'FontSize',24);
end

end
subplot(1,2,1);
imshow(image_original);

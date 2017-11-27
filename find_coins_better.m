

image_original = imread('coins7.jpg');
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
[image_1_centroid, number_1] = find1(image_original);

coins_5cent_cent = cat(1,image_5cents_centroid.Centroid);
coins_1 = cat(1,image_1_centroid.Centroid);

 coin_5cent_loc = [1];

 coin_1_loc = zeros(number_coins);
 
for i=1:1:number_5cent

for j=1:1:number_coins
if abs(coins_5cent_cent(i,1)-coins_cent(j,1)) <7 && abs(coins_5cent_cent(i,2)-coins_cent(j,2)) <7
coin_5cent_loc(i) = j; 
end
end
end

for i=1:1:number_1

for j=1:1:number_coins
if abs(coins_1(i,1)-coins_cent(j,1)) <7 && abs(coins_1(i,2)-coins_cent(j,2)) <7
coin_1_loc(j) = 1; 

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
 
    if (ratio(counter) == 0)
       image_original = insertText(image_original,coins_cent(counter,:),num2str(0.05),'FontSize',24);
    
    elseif (ratio(counter) >1.25) & (ratio(counter)<1.52) & (coin_1_loc(counter) ~= 1)
       image_original = insertText(image_original,coins_cent(counter,:),num2str(0.5),'FontSize',24);
     
    elseif (ratio(counter) >0.95) & (ratio(counter)<1.2) & (coin_1_loc(counter) ~= 1)
       image_original = insertText(image_original,coins_cent(counter,:),num2str(0.2),'FontSize',24);
   
       
    elseif (ratio(counter) >1.11) && (ratio(counter)<1.41) ||((coin_1_loc(counter) == 1) && (ratio(counter) >1.01) && (ratio(counter)<1.4))
       image_original = insertText(image_original,coins_cent(counter,:),num2str(1),'FontSize',24);

    
    elseif (ratio(counter) >1.53) && (ratio(counter)<1.8) ||((ratio(counter) >1.41) && (ratio(counter)<1.8) && coin_1_loc(counter) == 1)
       image_original = insertText(image_original,coins_cent(counter,:),num2str(2),'FontSize',24);

    elseif (ratio(counter) >1.25) & (ratio(counter)<1.52)
       image_original = insertText(image_original,coins_cent(counter,:),num2str(0.5),'FontSize',24);

    elseif (ratio(counter) >0.65) & (ratio(counter)<0.85)
        image_original = insertText(image_original,coins_cent(counter,:),num2str(0.1),'FontSize',24);
 
    elseif (ratio(counter) >0.95) & (ratio(counter)<1.11)
       image_original = insertText(image_original,coins_cent(counter,:),num2str(0.2),'FontSize',24);
    end


end

image_original = insertText(image_original,[0,0],cellstr("number of coins"),'FontSize',24);
image_original = insertText(image_original,[210,0],num2str(number_coins),'FontSize',24);

subplot(1,2,1);
imshow(image_original);

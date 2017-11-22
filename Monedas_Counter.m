figure
image_original = imread('coinsf.jpg');
[row, col, page] = size(image_original) ;

image_original=imresize(image_original,[1040,780]); 
 %used color mask to find 5cent coins because 5 cents and 20 cents has the
 %same size
[number_5cents, area_5cents] = find_5cent(image_original);
%used the area of    the 5cent coin to resize image for distance variations

if area_5cents<10000
     image_original = imresize(image_original,2.5);
     image_resised_flag =1;
end

subplot(2,5,2);
imshow(image_original);
[area_coins, number_coins, coins_cent] = find_number_coins(image_original);
 ratio = cell2mat(squeeze(struct2cell(area_coins)))/area_5cents;
% for counter = 1: 1: number_coins
    hold on
   
    if (ratio(1) >0.6) & (ratio(1)<0.8)
       insertText(image_original,coins_cent(1,:),"2E");  
    end
   
    hold off
% end
figure
imshow(image_original);
disp("the total number of coins is ");
disp(number_coins);

figure
image_original = imread('coinsg.jpg');
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
[area_coins, number_coins, coins_cent, coins_image] = find_number_coins(image_original);
 ratio = cell2mat(squeeze(struct2cell(area_coins)))/area_5cents;
 figure
 imshow(cell2mat(squeeze(struct2cell(coins_image(1,:)))));
%  for counter = 1: 1: number_coins
%     
%    
%     if (ratio(counter) >0.6) & (ratio(counter)<0.8)
%        image_original = insertText(image_original,coins_cent(counter,:),num2str(2),'FontSize',38);  
%        triggered = counter;
%    elseif (ratio(counter) >0.4) & (ratio(counter)<0.5)
%        image_original = insertText(image_original,coins_cent(counter,:),num2str(1),'FontSize',38); 
%     end
%     
%    
%     
%  end
% figure
% imshow(image_original);
disp("the total number of coins is ");
disp(number_coins);

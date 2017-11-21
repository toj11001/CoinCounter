figure
image_original = imread('coinse.jpg');
[row, col, page] = size(image_original) ;

image_original=imresize(image_original,[1040,780]); 
 %used color mask to find 5cent coins because 5 cents and 20 cents has the
 %same size
[number_5cents, area_5cents] = find_5cent(image_original);
%used the area of the 5cent coin to resize image for distance variations

if area_5cents>1000
   % image_original = imresize(image_original, area_5cents/4160);
end

subplot(2,5,2);
imshow(image_original);
[area_coins, number_coins, coins_cent] = find_number_coins(image_original);

% for counter = 1: 1: number,1_coins
%     hold on
%     ratio = area_coins/area_5cents;
%     if (ratio >1.6) && (ratio<1.8)
%         plot(coins_cent(counter),coins_cent(counter,2), 'b*','MarkerSize'20,'MarkerEdgeColor','g');    
%     end
%     if (ratio >1.) && (ratio<1.8)
%         plot(coins_cent(counter,1),coins_cent(counter,2), 'b*','MarkerSize'20,'MarkerEdgeColor','g');    
%     end
%     if (ratio >1.6) && (ratio<1.8)
%         plot(coins_cent(counter,1),coins_cent(counter,2), 'b*','MarkerSize'20,'MarkerEdgeColor','g');    
%     end
%     if (ratio >1.6) && (ratio<1.8)
%         plot(coins_cent(counter,1),coins_cent(counter,2), 'b*','MarkerSize'20,'MarkerEdgeColor','g');    
%     end
%     if (ratio >1.6) && (ratio<1.8)
%         plot(coins_cent(counter,1),coins_cent(counter,2), 'b*','MarkerSize'20,'MarkerEdgeColor','g');    
%     end
%     
%     hold off
% end

disp("the total number of coins is ");
disp(number_coins);

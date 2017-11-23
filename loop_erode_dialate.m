function [image_result, area,perimeter] = loop_erode_dialate(image_result, erode1, dialate1,erode2,accuracy)
loop_count =1;
figure
while true
[image_result, area, perimeter ] = erode_dialate(image_result,erode1,dialate1,erode2);
subplot(4,5,loop_count);
imshow(image_result);
loop_count = loop_count +1;
circularity = (perimeter .^ 2) ./ (4 * pi * area);
circ_mean = mean(circularity);
if (loop_count==15) break;
end
if (( circ_mean> 1-accuracy) &(circ_mean<1+accuracy)) break;
end


end
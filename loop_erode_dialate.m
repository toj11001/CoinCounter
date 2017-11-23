function [image_result, area,perimeter] = loop_erode_dialate(image_result, erode1, dialate1,erode2,accuracy, pre_count)
loop_count =1;
% figure('units','normalized','outerposition',[0 0 1 1])

if(pre_count == 0)
    
while true
[image_result, area, perimeter ] = erode_dialate(image_result,erode1,dialate1,erode2);
% subplot(3,4,loop_count);
% imshow(image_result);


circularity = (perimeter .^ 2) ./ (4 * pi * area);
circ_mean = mean(circularity);
if (loop_count==15) break;
end
if (( circ_mean> 1-accuracy) &(circ_mean<1+accuracy)) return;
end
loop_count = loop_count +1;
end

else 
while true
[image_result, area, perimeter ] = erode_dialate(image_result,erode1,dialate1,erode2);
% subplot(3,4,loop_count);
% imshow(image_result);
circularity = (perimeter .^ 2) ./ (4 * pi * area);
circ_mean = mean(circularity);
if (loop_count==pre_count) return;
end
loop_count = loop_count +1;
end
end
end
function [imageC] = projectIC(image,angle)
% projects the images on a cylindrical surface
%   image: planar image
%   imageC: image projected on the cylindrical surface
%   angle: half FOV of the camera 
%
%   Author: Leonardo Bonati
%   Date: July 2015

ig = rgb2gray(image);
[h w] = size(ig);
imageC = uint8(zeros(h,w));

alpha = angle/180*pi;
d = (w/2)/tan(alpha);
r = d/cos(alpha);



for x = -w/2+1:w/2
    for y = -h/2+1:h/2
      
       x1 = d * tan(x/r);
       y1 = y * (d/r) /cos(x/r);
       
       if x1 < w/2 && x1 > -w/2+1 && y1 < h/2 && y1 > -h/2+1 
            imageC(y+(h/2), x+(w/2) ) = ig(round(y1+(h/2)),round(x1+(w/2)));
        end
    end
end
end
    



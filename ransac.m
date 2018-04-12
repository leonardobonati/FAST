function [ compatible, translation_x ] = ransac( matches, frames1st, frames2nd, image_width )
% Select correct matches by choosing the biggest set of matches coherent
% between them
%   matches: Kx2 matrix with the matches
%   frames1st: Mx2 matrix with the points corresponding to the matches of the 
%   first image
%   frames2nd: Nx2 matrix with the points corresponding to the matches of the 
%   second image
%
%   Author: Leonardo Bonati
%   Date: July 2015

imgwidth=image_width;

total=0;
translation_x=0;
compatible = [];
for init=1:size(matches,1)
    dist_x=abs(frames2nd(matches(init,2),1) - frames1st(matches(init,1),1));
    dist_y=abs(frames2nd(matches(init,2),2) - frames1st(matches(init,1),2));
    
    comp = [];
    for i=1:size(matches,1)
        x1 = frames1st(matches(i,1),1);
        x2 = frames2nd(matches(i,2),1);
        
        y1 = frames1st(matches(i,1),2);
        y2 = frames2nd(matches(i,2),2);
        
        if abs(round(dist_y) - round(abs(y2-y1))) <= 3 && abs(round(dist_x) - round(abs(x2-x1))) <= 3
            comp = [comp; [matches(i,1), matches(i,2)]];
        end
    end
    
    if total < size(comp,1)
        total = size(comp,1);
        compatible = comp;
    end
end

for i=1:size(compatible,1)
    translation_x=translation_x+abs(imgwidth+frames2nd(compatible(i,2),1)-frames1st(compatible(i,1),1));
end
translation_x = floor(translation_x / (2*size(compatible,1)));
end
function [ output ] = fast( image_matrix, num_of_points, threshold, showPlot )
% FAST corner detection algorithm
%   image_matrix: MxN gray-scale matrix of the image
%   num_of_points (double): number of consecutive points to compare in
%   [9,12]
%   threshold (double): threshold for FAST corner detection algorithm
%   showPlot: 1 if final plot, 0 otherwise
%
%   Author: Leonardo Bonati
%   Date: July 2015

I=image_matrix;

corner_x=[];
corner_y=[];

T=threshold;

num=num_of_points;

% consider pixels
for x=4:size(I,2)-3
    for y=4:size(I,1)-3
        px=I(y,x);
        [wnd_x, wnd_y]=circwnd(x,y);
        
        if num>=12
            % rapid rejection
            if I(wnd_y(1),wnd_x(1))<=px-px*T && I(wnd_y(9),wnd_x(9))<=px-px*T
                if I(wnd_y(5),wnd_x(5))>=px-px*T && I(wnd_y(13),wnd_x(13))>=px-px*T
                    continue;
                end
            elseif I(wnd_y(1),wnd_x(1))>=px+px*T && I(wnd_y(9),wnd_x(9))>=px+px*T
                if I(wnd_y(5),wnd_x(5))<=px+px*T && I(wnd_y(13),wnd_x(13))<=px+px*T
                    continue;
                end
            elseif I(wnd_y(5),wnd_x(5))<=px-px*T && I(wnd_y(13),wnd_x(13))<=px-px*T
                if I(wnd_y(1),wnd_x(1))>=px-px*T && I(wnd_y(9),wnd_x(9))>=px-px*T
                    continue;
                end
            elseif I(wnd_y(5),wnd_x(5))>=px+px*T && I(wnd_y(13),wnd_x(13))>=px+px*T
                if I(wnd_y(1),wnd_x(1))<=px+px*T && I(wnd_y(9),wnd_x(9))<=px+px*T
                    continue;
                end
            end
        end
        
        % starting pixel of the circle
        for j=1:16
            % darker case
            if I(wnd_y(j),wnd_x(j))<=px-px*T
                count=1;
                examined=1;
                shift=j+1;
                
                if shift>16
                    shift=shift-16;
                end
                
                while examined<16 && count<num
                    if I(wnd_y(shift),wnd_x(shift))<=px-px*T
                        count=count+1;
                        examined=examined+1;
                        shift=shift+1;
                        
                        if shift>16
                            shift=shift-16;
                        end
                    else
                        break;
                    end
                end
                
                % pixel is a corner
                if count==num
                    corner_x=[corner_x;x];
                    corner_y=[corner_y;y];
                    break;
                end
            end
            
            % brighter case
            if I(wnd_y(j),wnd_x(j))>=px+px*T
                count=1;
                examined=1;
                shift=j+1;
                
                if shift>16
                    shift=shift-16;
                end
                
                while examined<16 && count<num
                    if I(wnd_y(shift),wnd_x(shift))>=px+px*T
                        count=count+1;
                        examined=examined+1;
                        shift=shift+1;
                        
                        if shift>16
                            shift=shift-16;
                        end
                    else
                        break;
                    end
                end
                
                % pixel is a corner
                if count==num
                    corner_x=[corner_x;x];
                    corner_y=[corner_y;y];
                    break;
                end
            end
        end
    end
end

% eliminate points that are too close
range=3;
for i=1:length(corner_x)
    if corner_x(i)==-1
        continue;
    end
    
    for j=i+1:length(corner_x)
        if abs(corner_x(i)-corner_x(j))<range
            if abs(corner_y(i)-corner_y(j))<range
                corner_x(j)=-1;
                corner_y(j)=-1;
            end
        end
    end
end

c_x=[];
c_y=[];
for i=1:length(corner_x)
    if corner_x(i)~=-1
        c_x=[c_x;corner_x(i)];
        c_y=[c_y;corner_y(i)];
    end
end

corner_x=c_x;
corner_y=c_y;

output=[corner_x,corner_y];

if showPlot==1
    % plot image
    figure;
    imshow(I);
    hold on;
    for i=1:length(corner_x)
        plot(corner_x(i),corner_y(i),'g+');
    end
    hold off;
end

end






function [ pixels_x, pixels_y ] = circwnd( px_x, px_y )
% Creates circular window of 16 pixels with centre the specified pixel
%   px_x (double): x-coordinate of the centre
%   px_y (double): y-coordinate of the centre
%
%   Author: Leonardo Bonati
%   Date: July 2015

pixels_x=zeros(16,1);
pixels_y=zeros(16,1);

%x coordinates
pixels_x(1)=px_x;
pixels_x(9)=px_x;

pixels_x(2)=px_x+1;
pixels_x(8)=px_x+1;

pixels_x(3)=px_x+2;
pixels_x(7)=px_x+2;

pixels_x(4)=px_x+3;
pixels_x(5)=px_x+3;
pixels_x(6)=px_x+3;


pixels_x(10)=px_x-1;
pixels_x(16)=px_x-1;

pixels_x(11)=px_x-2;
pixels_x(15)=px_x-2;

pixels_x(12)=px_x-3;
pixels_x(13)=px_x-3;
pixels_x(14)=px_x-3;



%y coordinates
pixels_y(5)=px_y;
pixels_y(13)=px_y;

pixels_y(4)=px_y-1;
pixels_y(14)=px_y-1;

pixels_y(3)=px_y-2;
pixels_y(15)=px_y-2;

pixels_y(1)=px_y-3;
pixels_y(2)=px_y-3;
pixels_y(16)=px_y-3;


pixels_y(6)=px_y+1;
pixels_y(12)=px_y+1;

pixels_y(7)=px_y+2;
pixels_y(11)=px_y+2;

pixels_y(8)=px_y+3;
pixels_y(9)=px_y+3;
pixels_y(10)=px_y+3;
end


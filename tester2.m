function [ ] = tester2( image, number_of_points, threshold )
% Comparison between designed FAST algorithm and detectFASTFeatures Matlab 
% function
%   image (string): first image to elaborate
%   number_of_points (double): number of points to compare for FAST corner
%   detection algorithm in [9,12]
%   threshold (double): threshold for FAST corner detection algorithm
%
%   Author: Leonardo Bonati
%   Date: July 2015

I=imread(image);
i=rgb2gray(I);

num=number_of_points;
thresh=threshold;

fast(I,num,thresh,1);

f=detectFASTFeatures(i);

figure;
imshow(i);
hold on;
plot(f.selectStrongest(92));
hold off;

end


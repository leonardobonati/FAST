function [ ] = tester( image1, image2, number_of_points, threshold, method )
% Test function for FAST corner detection and descriptor
%   image1 (string): first image to elaborate
%   image2 (string): second image to elaborate
%   number_of_points (double): number of points to compare for FAST corner
%   detection algorithm in [9,12]
%   threshold (double): threshold for FAST corner detection algorithm
%   method (string): descriptor extraction method, one between: BRISK,
%   FREAK, SURF, Block
%
%   Author: Leonardo Bonati
%   Date: July 2015

I1=imread(image1);
I2=imread(image2);

i1=rgb2gray(I1);
i2=rgb2gray(I2);

num=number_of_points;
thresh=threshold;
width=size(I1,2);

ig1=i1;
ig2=i2;

%detect features with FAST corner detection algorithm
det1=fast(ig1,num,thresh,0);
det2=fast(ig2,num,thresh,0);

%extract features using the specified method
[features1,vP1]=extractFeatures(ig1,det1,'Method',method);
[features2,vP2]=extractFeatures(ig2,det2,'Method',method);

%find matches between features
matches12=matchFeatures(features1,features2);

if strcmp(method,'SURF')
    x1 = round(vP1.Location);
    x2 = round(vP2.Location);
    vP1 = x1;
    vP2 = x2;
end

%select correct matches
mtc12=ransac(matches12,vP1,vP2,size(i1,2));

% plot
figure;
imshow([I1,I2]);
hold on;
for i=1:size(mtc12,1)
    plot(vP1(mtc12(i,1),1),vP1(mtc12(i,1),2),'gx');
    plot(vP2(mtc12(i,2),1)+width,vP2(mtc12(i,2),2),'gx');
    plot([vP1(mtc12(i,1),1),vP2(mtc12(i,2),1)+width],[vP1(mtc12(i,1),2),vP2(mtc12(i,2),2)],'g');
end

figure;
showMatchedFeatures(I1,I2,[vP1(mtc12(:,1),1),vP1(mtc12(:,1),2)],[vP2(mtc12(:,2),1),vP2(mtc12(:,2),2)])

end

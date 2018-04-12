function [ ] = tester3( number_of_points, threshold, method )
% Test function for FAST corner detection and descriptor for sequential
% images to stitch together
%   number_of_points (double): number of points to compare for FAST corner 
%   detection algorithm in [9,12]
%   threshold (double): threshold for FAST corner detection algorithm 
%   method (string): descriptor extraction method, one between: BRISK, 
%   FREAK, SURF, Block
%
%   Author: Leonardo Bonati
%   Date: July 2015

num=number_of_points;
thresh=threshold;

% get images (10)
i1 = imread('./images/i1.bmp');
i2 = imread('./images/i2.bmp');
i3 = imread('./images/i3.bmp');
i4 = imread('./images/i4.bmp');
i5 = imread('./images/i5.bmp');
i6 = imread('./images/i6.bmp');
i7 = imread('./images/i7.bmp');
i8 = imread('./images/i8.bmp');
i9 = imread('./images/i9.bmp');
i10 = imread('./images/i10.bmp');

alpha = 38.1;

%Project images on cylindrical surface
ig1 = projectIC(i1, alpha);
ig2 = projectIC(i2, alpha);
ig3 = projectIC(i3, alpha);
ig4 = projectIC(i4, alpha);
ig5 = projectIC(i5, alpha);
ig6 = projectIC(i6, alpha);
ig7 = projectIC(i7, alpha);
ig8 = projectIC(i8, alpha);
ig9 = projectIC(i9, alpha);
ig10 = projectIC(i10, alpha);

%detect features with FAST corner detection algorithm
det1=fast(ig1,num,thresh,0);
det2=fast(ig2,num,thresh,0);
det3=fast(ig3,num,thresh,0);
det4=fast(ig4,num,thresh,0);
det5=fast(ig5,num,thresh,0);
det6=fast(ig6,num,thresh,0);
det7=fast(ig7,num,thresh,0);
det8=fast(ig8,num,thresh,0);
det9=fast(ig9,num,thresh,0);
det10=fast(ig10,num,thresh,0);

%extract features using the specified method
[features1,vP1]=extractFeatures(ig1,det1,'Method',method);
[features2,vP2]=extractFeatures(ig2,det2,'Method',method);
[features3,vP3]=extractFeatures(ig3,det3,'Method',method);
[features4,vP4]=extractFeatures(ig4,det4,'Method',method);
[features5,vP5]=extractFeatures(ig5,det5,'Method',method);
[features6,vP6]=extractFeatures(ig6,det6,'Method',method);
[features7,vP7]=extractFeatures(ig7,det7,'Method',method);
[features8,vP8]=extractFeatures(ig8,det8,'Method',method);
[features9,vP9]=extractFeatures(ig9,det9,'Method',method);
[features10,vP10]=extractFeatures(ig10,det10,'Method',method);

%find matches between features
matches12=matchFeatures(features1,features2);
matches23=matchFeatures(features2,features3);
matches34=matchFeatures(features3,features4);
matches45=matchFeatures(features4,features5);
matches56=matchFeatures(features5,features6);
matches67=matchFeatures(features6,features7);
matches78=matchFeatures(features7,features8);
matches89=matchFeatures(features8,features9);
matches910=matchFeatures(features9,features10);
matches101=matchFeatures(features10,features1);

if strcmp(method,'SURF')
    vP1 = round(vP1.Location);
    vP2 = round(vP2.Location);
    vP3 = round(vP3.Location);
    vP4 = round(vP4.Location);
    vP5 = round(vP5.Location);
    vP6 = round(vP6.Location);
    vP7 = round(vP7.Location);
    vP8 = round(vP8.Location);
    vP9 = round(vP9.Location);
    vP10 = round(vP10.Location);
end

%select correct matches
[mtc12, transl12]=ransac(matches12,vP1,vP2,size(i1,2));
[mtc23, transl23]=ransac(matches23,vP2,vP3,size(i2,2));
[mtc34, transl34]=ransac(matches34,vP3,vP4,size(i3,2));
[mtc45, transl45]=ransac(matches45,vP4,vP5,size(i4,2));
[mtc56, transl56]=ransac(matches56,vP5,vP6,size(i5,2));
[mtc67, transl67]=ransac(matches67,vP6,vP7,size(i6,2));
[mtc78, transl78]=ransac(matches78,vP7,vP8,size(i7,2));
[mtc89, transl89]=ransac(matches89,vP8,vP9,size(i8,2));
[mtc910, transl910]=ransac(matches910,vP9,vP10,size(i9,2));
[mtc101, transl101]=ransac(matches101,vP10,vP1,size(i10,2));

%Fuse images together
matrix=[ig1(:,1:size(ig1,2)-transl12), ig2(:,transl12:size(ig2,2))];
matrix=[matrix(:,1:size(matrix,2)-transl23), ig3(:,transl23:size(ig3,2))];
matrix=[matrix(:,1:size(matrix,2)-transl34), ig4(:,transl34:size(ig4,2))];
matrix=[matrix(:,1:size(matrix,2)-transl45), ig5(:,transl45:size(ig5,2))];
matrix=[matrix(:,1:size(matrix,2)-transl56), ig6(:,transl56:size(ig6,2))];
matrix=[matrix(:,1:size(matrix,2)-transl67), ig7(:,transl67:size(ig7,2))];
matrix=[matrix(:,1:size(matrix,2)-transl78), ig8(:,transl78:size(ig8,2))];
matrix=[matrix(:,1:size(matrix,2)-transl89), ig9(:,transl89:size(ig9,2))];
matrix=[matrix(:,1:size(matrix,2)-transl910), ig10(:,transl910:size(ig10,2))];
matrix = matrix(:,1:size(matrix,2)-2*transl101);

imshow(matrix);

end

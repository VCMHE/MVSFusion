clc;
close all;
addpath functions
tic;


labels = [1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1];
for i = 1:21 
    
    PathIr           = [ 'D:\Users\Administrator\Desktop\MVSFusion\TNO\IR\IR (' ,        num2str(i) ,        ').png' ]; 
    PathVis          =  [ 'D:\Users\Administrator\Desktop\MVSFusion\TNO\VIS\VIS (' ,        num2str(i) ,       ').png'  ];
    FusionPath       = [ 'D:\Users\Administrator\Desktop\MVSFusion\result\TNO\MSVFUsion',   num2str(i) ,          '.png' ];
    
    
    % Read images
    ImgIr  = imread(PathIr);  
    ImgVis = imread(PathVis);
    
    
    if size(ImgIr, 3) ~= 1
        ImgIr  = rgb2gray(ImgIr);
    end
    ImgSuper = im2double(performSLIC(ImgIr));
    
    % Start fusion
    % Add the code to read the label value from the list and assign it to variable 'c'
    c = labels(i);
    image = main(im2double(ImgIr), im2double(ImgVis), ImgSuper, FusionPath, c);
%      fprintf("%d\n", i);
%      fprintf("%d\n", c);
end

toc;

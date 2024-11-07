function [img] = point_1(img_o)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

img=rgb2hsv(img_o);
figure,image(img)
figure,subplot(236)
subplot(231),imagesc(img(:,:,1)),colormap gray,title('R component')%as intensity
subplot(232),imagesc(img(:,:,2)),colormap gray,title('G component')%as intensity
subplot(233),imagesc(img(:,:,3)),colormap gray,title('B component')%as intensity
subplot(234),imagesc(img(:,:,1)),colormap gray,title('H component')%as intensity
subplot(235),imagesc(img(:,:,2)),colormap gray,title('S component')%as intensity
subplot(236),imagesc(img(:,:,3)),colormap gray,title('V component')%as intensity

end
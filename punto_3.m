function [meanHue,stdHue] = punto_3(img)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
% Load a single image (assuming filename is 'ur_c_s_03a_01_L_0376.png')


% Define the Region of Interest (ROI) coordinates for the dark car (adjust as needed)
roiRowStart = 390;
roiRowEnd = 400;
roiColStart = 575;
roiColEnd = 595;

% Convert the image to HSV
hsvImage = rgb2hsv(img);

% Define the ROI for the dark car
carAreaHue = hsvImage(roiRowStart:roiRowEnd, roiColStart:roiColEnd, 1);

% Calculate the mean and standard deviation of the Hue values in the ROI
meanHue = mean(carAreaHue, 'all');
stdHue = std(carAreaHue, 0, 'all');

% Display the mean and standard deviation of the Hue values


end
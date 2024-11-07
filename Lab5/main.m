addpath('images\');

% Load the reference image and convert to grayscale if necessary The size(refImage, 3) checks if the image has three channels 
% (color image). If it does, rgb2gray(refImage) converts it to grayscale, which is needed for processing with normxcorr2, 
% as this function expects 2D matrices.
refImage = imread('ur_c_s_03a_01_L_0376.png');
if size(refImage, 3) == 3
    refImage = rgb2gray(refImage);
end

% Display the reference image to manually select the red car template
figure, imshow(refImage);
title('Select the Red Car Template');
redCarTemplate = imcrop(refImage); % Select the template 
% manually imcrop(refImage); opens a cropping tool 
% for selecting a region around the red car in the 
% displayed image. The selected region is stored in 
% redCarTemplate and serves as our template to find 
% in other images.

% Get the dimensions of the template
[templateHeight, templateWidth] = size(redCarTemplate);

% Display the selected template
figure, imshow(redCarTemplate);
title('Red Car Template');

% Path to images - assuming the 6 images are in the current directory
imageFiles = {'ur_c_s_03a_01_L_0376.png', 'ur_c_s_03a_01_L_0377.png', 'ur_c_s_03a_01_L_0378.png', 'ur_c_s_03a_01_L_0379.png', 'ur_c_s_03a_01_L_0380.png', 'ur_c_s_03a_01_L_0381.png'};

% Loop through each image
for i = 1:length(imageFiles)
    % Load and convert each image to grayscale
    currentImage = imread(imageFiles{i});
    if size(currentImage, 3) == 3
        currentImage = rgb2gray(currentImage);
    end
    
    % Perform normalized cross-correlation
    scoreMap = normxcorr2(redCarTemplate, currentImage);
    %normxcorr2 computes the normalized cross-correlation between the redCarTemplate and currentImage.
    %The output scoreMap is a matrix where each value represents the correlation between the template and that region of the image.
    %Higher values in scoreMap indicate stronger matches.
    
    % Find the peak of the correlation map
    [maxCorrY, maxCorrX] = find(scoreMap == max(scoreMap(:))); 
    
    %max(scoreMap(:)) finds the highest correlation value in scoreMap, which corresponds to the best match location.
    %[maxCorrY, maxCorrX] = find(...) returns the coordinates of the maximum correlation in scoreMap.
    
    % Adjust to get the location in the original image
    yTopLeft = maxCorrY - templateHeight + 1;
    xTopLeft = maxCorrX - templateWidth + 1;
    
    %maxCorrY and maxCorrX are the coordinates of the center of the template in scoreMap, but we need the top-left corner.
    %By subtracting the template dimensions, we adjust xTopLeft and yTopLeft to the coordinates of the top-left corner of the bounding box in the original image.

    % Display the current image with the bounding box around the match
    figure, imshow(currentImage);
    hold on;
    rectangle('Position', [xTopLeft, yTopLeft, templateWidth, templateHeight], ...
              'EdgeColor', 'r', 'LineWidth', 2);
    title(['Red Car Location in Image ', num2str(i)]);
    hold off;
end

% Repeat for the dark car template
figure, imshow(refImage);
title('Select the Dark Car Template');
darkCarTemplate = imcrop(refImage); % Select the template manually

% Display the selected dark car template
figure, imshow(darkCarTemplate);
title('Dark Car Template');

% Loop through each image for the dark car
for i = 1:length(imageFiles)
    % Load and convert each image to grayscale
    currentImage = imread(imageFiles{i});
    if size(currentImage, 3) == 3
        currentImage = rgb2gray(currentImage);
    end
    
    % Perform normalized cross-correlation
    scoreMap = normxcorr2(darkCarTemplate, currentImage);
    
    % Find the peak of the correlation map
    [maxCorrY, maxCorrX] = find(scoreMap == max(scoreMap(:)));
    
    % Adjust to get the location in the original image
    yTopLeft = maxCorrY - size(darkCarTemplate, 1) + 1;
    xTopLeft = maxCorrX - size(darkCarTemplate, 2) + 1;
    
    % Display the current image with the bounding box around the match
    figure, imshow(currentImage);
    hold on;
    rectangle('Position', [xTopLeft, yTopLeft, size(darkCarTemplate, 2), size(darkCarTemplate, 1)], ...
              'EdgeColor', 'b', 'LineWidth', 2);
    title(['Dark Car Location in Image ', num2str(i)]);
    hold off;
end

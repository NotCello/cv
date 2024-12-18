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
% %% point 2
% % Load and convert the image to grayscale if necessary
% image = imread('i235.png');
% if size(image, 3) == 3
%     image = rgb2gray(image);
% end
% image = im2double(image);  % Convert to double precision for accurate calculations
% 
% % Parameters for the Harris corner detector
% windowSize = 5;     % Window size for Gaussian smoothing
% sigma = 1;          % Standard deviation for Gaussian filter
% k = 0.04;           % Harris detector constant (between 0.04 and 0.06)
% 
% % 1. Compute Partial Derivatives of the Image
% [Ix, Iy] = imgradientxy(image);  % Gradient in x and y directions
% figure, imshow(Ix, []), title('Partial Derivative in x-direction');
% figure, imshow(Iy, []), title('Partial Derivative in y-direction');
% 
% % 2. Apply Gaussian Smoothing to the Products of Derivatives
% G = fspecial('gaussian', windowSize, sigma);  % Gaussian filter
% 
% Ixx = imfilter(Ix.^2, G);
% Iyy = imfilter(Iy.^2, G);
% Ixy = imfilter(Ix .* Iy, G);
% 
% % Display the Gaussian filter
% figure, imshow(G, []), title('Gaussian Filter');
% 
% % 3. Compute the R Score Map (Harris Response)
% R = (Ixx .* Iyy - Ixy.^2) - k * (Ixx + Iyy).^2;
% 
% % Display the R score map
% figure, imshow(R, []), title('R Score Map');
% 
% % 4. Threshold the R Score Map to Find Corner Regions
% threshold = 0.3 * max(R(:));   % Threshold as 0.3 * max(R)
% cornerRegions = R > threshold; % Binary map of corner regions
% 
% figure, imshow(cornerRegions, []), title('Corner Regions');
% 
% % 5. Detect Corners Using Centroids of Corner Regions
% % Use regionprops to find centroids of detected corner regions
% stats = regionprops(cornerRegions, 'Centroid');
% centroids = cat(1, stats.Centroid);
% 
% % 6. Display the Detected Corners Overlapped on the Original Image
% figure, imshow(image), title('Detected Corners');
% hold on;
% plot(centroids(:,1), centroids(:,2), 'r+', 'MarkerSize', 5, 'LineWidth', 1.5);
% hold off;
% 
% Harris corner detector implementation on image i235.png

%%  Load the image
tmp = imread('i235.png', 'png');
I = double(tmp);
figure, imagesc(I), colormap gray, title('Original Image');

% Compute x and y derivative of the image
dx = [1 0 -1; 2 0 -2; 1 0 -1]; 
dy = [1 2 1; 0 0 0; -1 -2 -1]; %dx e dy are the sobel filters of the derivatives of the image.
% this filters are utilized to find the changes of hue along x and y
Ix = conv2(I, dx, 'same');
Iy = conv2(I, dy, 'same');
%apply the filter dx to the image to find the oriozontal derivative and the
%vertical derivative
figure, imagesc(Ix), colormap gray, title('Partial Derivative Ix');
figure, imagesc(Iy), colormap gray, title('Partial Derivative Iy');

% Compute products of derivatives at every pixel
Ix2 = Ix .* Ix; 
Iy2 = Iy .* Iy; 
Ixy = Ix .* Iy;
% i compute the product of the derivative, they represent the local
% variance of the intensity along different direcion and are used to built
% the harris matrix
%this product will be used to compute the matric of moment

% Compute the sum of products of derivatives at each pixel
g = fspecial('gaussian', 9, 1.2);
figure, imagesc(g), colormap gray, title('Gaussian Filter');
Sx2 = conv2(Ix2, g, 'same'); 
Sy2 = conv2(Iy2, g, 'same'); 
Sxy = conv2(Ixy, g, 'same');
% I create a giltere 9x9 con dev std 1.2. This filter is used to smooth the
% product of the derivative in order to make the analysis less sensitive to
% the disturbances. This filter is used to smooth the derivative produce 
% reducing the sensitivity of disturbance.
% then i make the convolution with the filter, to get the ponderate sum of
% the derivatives along x, same for y,and i make the convolution of the
% product.
% sx2, sy2, sxy sono ottenuti convolvendo rispettivamente  con il filtro 
% gaussiano. Questa lisciatura è necessaria per migliorare la stabilità 
% del rilevamento degli angoli e ridurre il rumore.



% Feature detection
[rr, cc] = size(Sx2); %determin the image dimension
R_map = zeros(rr, cc);
k = 0.05;

% for every pixel i build the matrix moment that describe the variation of
% hue
for ii = 1:rr
    for jj = 1:cc
        % Define at each pixel (x, y) the matrix M
        M = [Sx2(ii, jj), Sxy(ii, jj); Sxy(ii, jj), Sy2(ii, jj)];
        % Compute the response of the detector at each pixel
        R = det(M) - k * (trace(M)^2); %The value of R permit to determin 
        % if a pixel is in a region of corners, angles or flat region
        R_map(ii, jj) = R;
    end
end

% Show the R score map
figure, imagesc(R_map), colormap jet, title('R Score Map');

% Threshold for corner regions
M = max(R_map(:));
corner_threshold = 0.3 * M; %i put the soglia at 30% of the maximum value of R
% the pixel with a value bigger than this soglia are considered angles
corner_reg = R_map > corner_threshold; %I create a binary map where pixel are angles
figure, imagesc(corner_reg .* I), colormap gray, title('Corner Regions');

% Find centroids of the corner regions using regionprops
stats = regionprops(corner_reg, 'Centroid'); %i find the centroidi of the blon
centroids = cat(1, stats.Centroid);% concateno i centroidi in una matrice in cui ogni riga è un centroide

% Show the detected corners overlapped to the original image
figure, imshow(tmp), title('Detected Corners Overlapped');
hold on;
plot(centroids(:,1), centroids(:,2), 'r+', 'MarkerSize', 10, 'LineWidth', 2);
hold off;

%: Sovrappone i punti rilevati (angoli) sull'immagine originale 
% utilizzando dei simboli rossi ('r+'). Questa visualizzazione aiuta a 
% verificare se gli angoli sono stati rilevati correttamente.

addpath('images\');
% Array per salvare i nomi delle immagini
imageNames = {'ur_c_s_03a_01_L_0376.png', 'ur_c_s_03a_01_L_0377.png', 'ur_c_s_03a_01_L_0378.png', 'ur_c_s_03a_01_L_0379.png', 'ur_c_s_03a_01_L_0380.png', 'ur_c_s_03a_01_L_0380.png'};
% Number of images to work with
numImages = 81;

% Loop over each image to perform the requested operations
for i = 76:numImages
    % Load the image (assuming filenames are 'image1.jpg', 'image2.jpg', ..., 'image6.jpg')
    filename = sprintf('ur_c_s_03a_01_L_03%d.png', i);
    img = imread(filename);
    figure(),imshow(img), colormap gray;
    
    % Display original image in grayscale
    figure;
    subplot(3, 3, 1);
    imshow(rgb2gray(img));
    title(['Image ', num2str(i), ' in Grayscale']);
    
    % Split the image into RGB channels
    R = img(:, :, 1); % Red channel
    G = img(:, :, 2); % Green channel
    B = img(:, :, 3); % Blue channel
    
    % Display the RGB channels
    subplot(3, 3, 2);
    imshow(R);
    title('Red Channel');
    
    subplot(3, 3, 3);
    imshow(G);
    title('Green Channel');
    
    subplot(3, 3, 4);
    imshow(B);
    title('Blue Channel');
    
    % Convert the image to HSV
    hsvImage = rgb2hsv(img);
    
    % Split the image into HSV channels
    H = hsvImage(:, :, 1); % Hue channel
    S = hsvImage(:, :, 2); % Saturation channel
    V = hsvImage(:, :, 3); % Value channel
    
    % Display the HSV channels
    subplot(3, 3, 5);
    imshow(H);
    title('Hue Channel');
    
    subplot(3, 3, 6);
    imshow(S);
    title('Saturation Channel');
    
    subplot(3, 3, 7);
    imshow(V);
    title('Value Channel');
    carAreaHue = H(100:200, 150:250); % Example coordinates for car area, adjust as needed
        plot(reshape(carAreaHue, [], 1), 'm');
        title(['Hue Variation in Dark Car Area - Image ', num2str(i)]);
        xlabel('Pixel Index');
        ylabel('Hue Value');
end
%cosa faccio?
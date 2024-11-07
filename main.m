 addpath('images\');
% % Array per salvare i nomi delle immagini
% imageNames = {'ur_c_s_03a_01_L_0376.png', 'ur_c_s_03a_01_L_0377.png', 'ur_c_s_03a_01_L_0378.png', 'ur_c_s_03a_01_L_0379.png', 'ur_c_s_03a_01_L_0380.png', 'ur_c_s_03a_01_L_0380.png'};
% % Number of images to work with
% numImages = 81;
% 
% % Loop over each image to perform the requested operations
% for i = 76:numImages
%     % Load the image (assuming filenames are 'image1.jpg', 'image2.jpg', ..., 'image6.jpg')
%     filename = sprintf('ur_c_s_03a_01_L_03%d.png', i);
%     img = imread(filename);
%     figure(),imshow(img), colormap gray;
%     
%     % Display original image in grayscale
%     figure;
%     subplot(3, 3, 1);
%     imshow(rgb2gray(img));
%     title(['Image ', num2str(i), ' in Grayscale']);
%     
%     % Split the image into RGB channels
%     R = img(:, :, 1); % Red channel
%     G = img(:, :, 2); % Green channel
%     B = img(:, :, 3); % Blue channel
%     
%     % Display the RGB channels
%     subplot(3, 3, 2);
%     imshow(R);
%     title('Red Channel');
%     
%     subplot(3, 3, 3);
%     imshow(G);
%     title('Green Channel');
%     
%     subplot(3, 3, 4);
%     imshow(B);
%     title('Blue Channel');
%     
%     % Convert the image to HSV
%     hsvImage = rgb2hsv(img);
%     
%     % Split the image into HSV channels
%     H = hsvImage(:, :, 1); % Hue channel
%     S = hsvImage(:, :, 2); % Saturation channel
%     V = hsvImage(:, :, 3); % Value channel
%     
%     % Display the HSV channels
%     subplot(3, 3, 5);
%     imshow(H);
%     title('Hue Channel');
%     
%     subplot(3, 3, 6);
%     imshow(S);
%     title('Saturation Channel');
%     
%     subplot(3, 3, 7);
%     imshow(V);
%     title('Value Channel');
%     carAreaHue = H(100:200, 150:250); % Example coordinates for car area, adjust as needed
%         plot(reshape(carAreaHue, [], 1), 'm');
%         title(['Hue Variation in Dark Car Area - Image ', num2str(i)]);
%         xlabel('Pixel Index');
%         ylabel('Hue Value');
% end
% %cosa faccio?

clc; close all; clear all;


%Display the 6 images in grayscale and split them in the three RGB channels and in 
%the three HSV channels.

img = cell(1, 6);

%% Separating components and plot

img{1}=imread('ur_c_s_03a_01_L_0376.png');
img{2}=imread('ur_c_s_03a_01_L_0377.png');
img{3}=imread('ur_c_s_03a_01_L_0378.png');
img{4}=imread('ur_c_s_03a_01_L_0379.png');
img{5}=imread('ur_c_s_03a_01_L_0380.png');
img{6}=imread('ur_c_s_03a_01_L_0381.png');

for i=1:6
    figure;
    subplot(1,3,1),imshow(img{i}(:,:,1)),title('Red');
    subplot(1,3,2),imshow(img{i}(:,:,2));title('Green');
    subplot(1,3,3),imshow(img{i}(:,:,3));title('Blue');
    
    img_hsv=rgb2hsv(img{i});

    if i==1
        img_selected_hsv = img_hsv;
    end
    
    figure;
    subplot(1,3,1),imshow(img_hsv(:,:,1)),title('Hue');
    subplot(1,3,2),imshow(img_hsv(:,:,2));title('Saturation');
    subplot(1,3,3),imshow(img_hsv(:,:,3));title('Value');
end

%Select in the image “ur_c_s_03a_01_L_0376.png” the area corresponding to the 
%dark car that turns on the left, e.g. area [390:400,575:595]. In this area compute 
%the mean value (m) and the standard deviation (s) of the Hue component
figure,imshow(img_selected_hsv)
img_selected_hsv_1comp = img_selected_hsv(390:400,575:595,1);
m = mean(img_selected_hsv_1comp(:))
s = std(img_selected_hsv_1comp(:))

%Segment the dark car in the 6 images by thresholding the Hue component (e.g. in 
%the range between m-s and m+s)

%simple segmentation
img_hsv = img_selected_hsv;
[rr,cc,pp]=size(img_hsv);
seg=zeros(rr,cc);
mask=img_hsv(:,:,1)>(m-s) & img_hsv(:,:,1)<(m+s); %threshold on the hue componet
seg=seg+mask;
figure,imagesc(seg),colormap gray, title('segmented object (blob)') %binary image (segmented image, i.e. detection of a given color)

%% Display (i) the binary images corresponding to the segmentation and the related 
%centroid and bounding box; (ii) the centroid and bounding box overlapped on the 
%color image (tips: regionprops() function needs a logical matrix; display the 
%bounding box of the blob with the highest area; see Fig.1).

close all

prop=regionprops(mask, 'Area','Centroid','BoundingBox');
xc=floor(prop(1).Centroid(1));
yc=floor(prop(1).Centroid(2));
ul_corner_width=prop(1).BoundingBox;
figure,imagesc(seg),colormap gray,title('detected object')
hold on
plot(xc,yc,'*r')
rectangle('Position',ul_corner_width,'EdgeColor',[1,0,0])
hold off
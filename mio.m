addpath('images\');
%% point 1

img_rgb=imread('ur_c_s_03a_01_L_0376.png');
img_hsv_76=point_1(img_rgb);
img_rgb=imread('ur_c_s_03a_01_L_0377.png');
img_hsv_77=point_1(img_rgb);
img_rgb=imread('ur_c_s_03a_01_L_0378.png');
img_hsv__78=point_1(img_rgb);
img_rgb=imread('ur_c_s_03a_01_L_0379.png');
img_hsv_79=point_1(img_rgb);
img_rgb=imread('ur_c_s_03a_01_L_0380.png');
img_hsv_80=point_1(img_rgb);
img_rgb=imread('ur_c_s_03a_01_L_0381.png');
img_hsv_81=point_1(img_rgb);


img=imread('ur_c_s_03a_01_L_0376.png');
[img_mean,std_img]=punto_3(img);
figure(), imshow(std_img);
figure(), imshow(std_img);


% 
% % Load a single image (assuming filename is 'image1.jpg')
% filename = 'ur_c_s_03a_01_L_0376.png';
% img = imread(filename);
% 
% % Define the Region of Interest (ROI) coordinates for the dark car (adjust as needed)
% roiRowStart = 1;
% roiRowEnd = 300;
% roiColStart = 350;
% roiColEnd = 500;
% 
% % Convert the image to grayscale and HSV
% imgGray = rgb2gray(img);
% hsvImage = rgb2hsv(img);
% 
% % Define the ROI for the dark car
% carAreaRGB = img(roiRowStart:roiRowEnd, roiColStart:roiColEnd);
% carAreaHue = hsvImage(roiRowStart:roiRowEnd, roiColStart:roiColEnd, 1);
% 
% % Calculate the average RGB and Hue values in the ROI
% avgR = mean(carAreaRGB(:, :, 1), 'all');
% avgG = mean(carAreaRGB(:, :, 2), 'all');
% avgB = mean(carAreaRGB(:, :, 3), 'all');
% avgHue = mean(carAreaHue, 'all');
% 
% % Display the average RGB values
% fprintf('Average Red: %.2f\n', avgR);
% fprintf('Average Green: %.2f\n', avgG);
% fprintf('Average Blue: %.2f\n', avgB);
% 
% % Display the average Hue value
% fprintf('Average Hue: %.2f\n', avgHue);
% % img = imread('ur_c_s_03a_01_L_0381.png'); % Load an example image
% % imshow(img); % Display the image
% % h = drawrectangle; % Draw a rectangle on the image
% % 
% % % Get the position of the ROI
% % pos = round(h.Position); % [x, y, width, height]
% % x = pos(1);
% % y = pos(2);
% % w = pos(3);
% % h = pos(4);
% % 
% % % Extract the Region of Interest
% % roi = img(y:(y+h-1), x:(x+w-1), :);
% % 
% % 
% % 
% % 
% % 
% % 
% % %simple segmentation
% % [rr,cc,pp]=size(img_hsv);
% % seg=zeros(rr,cc);
% % mask=img_hsv(:,:,1)>0.40 & img_hsv(:,:,1)<0.44; %threshold on the hue componet
% % seg=seg+mask;
% % figure,imagesc(seg),colormap gray, title('segmented object (blob)') %binary image (segmented image, i.e. detection of a given color)
% % 
% % %%%Properties of image regions  (blob analysis)
% % %binary image seg has only one detected object, the white area (blob), thus
% % %we can consider the seg image as labeled one, i.e. the unique blob has
% % %label 1
% % prop=regionprops(seg, 'Area','Centroid','BoundingBox');
% % xc=floor(prop(1).Centroid(1));
% % yc=floor(prop(1).Centroid(2));
% % ul_corner_width=prop(1).BoundingBox;
% % figure,imagesc(seg),colormap gray,title('detected object')
% % hold on
% % plot(xc,yc,'*r')
% % rectangle('Position',ul_corner_width,'EdgeColor',[1,0,0])
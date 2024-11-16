% MATLAB Implementation for Color-Based Segmentation: Focusing on Tasks 3, 4, and 5

% Define image files
imageFiles = {'ur_c_s_03a_01_L_0376.png', 'ur_c_s_03a_01_L_0377.png', 'ur_c_s_03a_01_L_0378.png', 'ur_c_s_03a_01_L_0379.png', 'ur_c_s_03a_01_L_0380.png', 'ur_c_s_03a_01_L_0381.png'};

% Task 3: Select Area of the Dark Car and Calculate Mean and Standard Deviation
selected_image = imread(imageFiles{1});
hsv_selected = rgb2hsv(selected_image);
hue_selected = hsv_selected(390:400, 575:595, 1);  % Extract Hue component in the selected area

mean_hue = mean(hue_selected(:));
std_hue = std(hue_selected(:));
disp(['Mean Hue: ', num2str(mean_hue), ', Standard Deviation: ', num2str(std_hue)]);

% Task 4: Segment the Dark Car in the 6 Images Using the Hue Threshold
for i = 1:length(imageFiles)
    img = imread(imageFiles{i});
    hsv = rgb2hsv(img);
    h = hsv(:, :, 1);
    
    % Thresholding using mean and standard deviation
    lower_bound = mean_hue - std_hue;
    upper_bound = mean_hue + std_hue;
    mask = (h >= lower_bound) & (h <= upper_bound);
    
    % Task 5: Display Binary Images and Centroid/Bounding Box
    labeled_mask = bwlabel(mask);
    stats = regionprops(labeled_mask, 'Area', 'Centroid', 'BoundingBox');
    
    % Find the region with the largest area (assumed to be the car)
    if ~isempty(stats)
        [~, idx] = max([stats.Area]);
        largest_region = stats(idx);
        
        % Extract centroid and bounding box
        centroid = largest_region.Centroid;
        bbox = largest_region.BoundingBox;
        
        % Display binary mask
        figure, imshow(mask), title(['Image ', num2str(i), ' - Binary Mask']);
        
        % Draw centroid and bounding box on the original image using standard MATLAB functions
        output_img = img;
        figure, imshow(output_img), title(['Image ', num2str(i), ' - Bounding Box and Centroid']);
        hold on;
        rectangle('Position', bbox, 'EdgeColor', 'g', 'LineWidth', 2);
        plot(centroid(1), centroid(2), 'r+', 'MarkerSize', 10, 'LineWidth', 2);
        hold off;
    end
end

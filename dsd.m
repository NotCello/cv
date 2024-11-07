% Funzione 1: Visualizza le immagini in scala di grigi e separa i canali RGB e HSV
function displayAndSplitImages(imageFiles)
    % imageFiles: cell array contenente i percorsi delle 6 immagini
    numImages = length(imageFiles);
    
    for i = 1:numImages
        % Leggi l'immagine
        img = imread(imageFiles{i});
        
        % Convertila in scala di grigi e visualizzala
        grayImg = rgb2gray(img);
        figure, imshow(grayImg), title(['Grayscale Image ', num2str(i)]);
        
        % Separazione dei canali RGB
        R = img(:,:,1);
        G = img(:,:,2);
        B = img(:,:,3);
        
        % Visualizzazione dei canali RGB
        figure;
        subplot(1, 3, 1), imshow(R), title(['Red Channel ', num2str(i)]);
        subplot(1, 3, 2), imshow(G), title(['Green Channel ', num2str(i)]);
        subplot(1, 3, 3), imshow(B), title(['Blue Channel ', num2str(i)]);
        
        % Conversione in HSV e separazione dei canali
        hsvImg = rgb2hsv(img);
        H = hsvImg(:,:,1);
        S = hsvImg(:,:,2);
        V = hsvImg(:,:,3);
        
        % Visualizzazione dei canali HSV
        figure;
        subplot(1, 3, 1), imshow(H), title(['Hue Channel ', num2str(i)]);
        subplot(1, 3, 2), imshow(S), title(['Saturation Channel ', num2str(i)]);
        subplot(1, 3, 3), imshow(V), title(['Value Channel ', num2str(i)]);
    end
end

% Funzione 2: Nota la variazione delle componenti RGB e della Hue nell'area dell'auto scura
function analyzeCarArea(imageFiles, carMask)
    % imageFiles: cell array contenente i percorsi delle 6 immagini
    % carMask: maschera binaria dell'area dell'auto (stessa dimensione delle immagini)
    numImages = length(imageFiles);
    
    for i = 1:numImages
        % Leggi l'immagine
        img = imread(imageFiles{i});
        
        % Estrai i canali RGB
        R = img(:,:,1);
        G = img(:,:,2);
        B = img(:,:,3);
        
        % Applica la maschera dell'auto scura ai canali RGB
        carR = R(carMask);
        carG = G(carMask);
        carB = B(carMask);
        
        % Calcola la media dei valori per ogni canale RGB nell'area dell'auto
        meanR = mean(carR);
        meanG = mean(carG);
        meanB = mean(carB);
        
        % Conversione in HSV e estrazione del canale Hue
        hsvImg = rgb2hsv(img);
        H = hsvImg(:,:,1);
        carH = H(carMask);
        
        % Calcola la media del valore di Hue nell'area dell'auto
        meanH = mean(carH);
        
        % Visualizza i risultati per l'immagine corrente
        fprintf('Image %d - Mean RGB values: R=%.2f, G=%.2f, B=%.2f, Mean Hue=%.2f
', ...
                i, meanR, meanG, meanB, meanH);
    end
end

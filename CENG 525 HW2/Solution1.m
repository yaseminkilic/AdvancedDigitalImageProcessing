% The DFT of an image is a transform from the space domain (in mm or cm) 
% to the spatial frequency domain

function Solution1()
   
    % Read a gray scale image
    % img = imread('question_1.tif');
    % dimg = double(img); 
    % figure(1), imshow(img), title('Original Image');
    % figure(2), mesh(dimg), title('Mesh of Original Image');
    % F=fft2(dimg);
    % To display it in the center (The zero-frequency coefficient is displayed in the upper left hand) corner. 
    % F2=shiftFrequencyToCenter(F);
    
    F2= fft2image('question_1.tif');
    
    % To compute the magnitude f the combined components(real and imaginary parts to F)
    F2=abs(F2);
    % Reduce contrast (high peaks are so high they hide details)
    F2=log(1+F2); 
    figure(3), imshow(F2, []), title('Centered and log-scaled spectrum'); 
end
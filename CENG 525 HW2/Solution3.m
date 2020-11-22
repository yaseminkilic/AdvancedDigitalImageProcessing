function Solution3()
    % Read a gray scale image
    Image_tif = imread('question_3.tif');
    Image = im2double(Image_tif);
    [row col]=size(Image);
    figure(1), imshow(Image_tif), title('Original Image');

    %Determine good padding for Fourier transform 
    PQ = paddedsize([row col]); 
    
    %Create ideal lowpass with a radius of 30 pixels of the Fourier transform 
    D0 = 30; 
    % create a blurred (or smoothed) image 
    % attenuate the high frequencies
    % leave the low frequencies of the Fourier transform relatively unchanged
    H = LowpassFilter('idealpass', PQ(1), PQ(2), D0); 
    
    % Calculate the discrete Fourier transform of the image 
    F = fft2(Image,size(H,1),size(H,2)); 
    
    % Apply the idealpass filter to the Fourier spectrum of the image 
    LPFS = H.*F; 
    
    % convert the result to the spacial domain. 
    LPF_spacial = real(ifft2(LPFS)); 
    
    % Crop the image to undo padding 
    LPF_spacial = LPF_spacial(1:row, 1:col); 
    %Display the blurred image 
    figure(2), imshow(LPF_spacial, []), title('Idealpass filter of the Fourier spectrum in the spacial domain');
    figure(3), imshow(abs(LPF_spacial), []), title('Abs Idealpass filter of the Fourier spectrum in the spacial domain');
    
    % Move the origin of the transform to the center of the frequency rectangle. 
    %Fc = shiftFrequencyToCenter(F); 
    %Fcf = shiftFrequencyToCenter(LPFS);
    
    % abs to compute the magnitude
    % log to brighten display 
    % S1=log(1+abs(Fc)); 
    % S2=log(1+abs(Fcf)); 
    % figure(3), imshow(S1,[]), title('Abs of Discrete Fourier Transform of Image');
    % figure(4), imshow(S2,[]), title('Idealpass of Fourier spectrum of Image');
end
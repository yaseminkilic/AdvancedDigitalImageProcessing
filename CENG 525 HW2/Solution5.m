function Solution5() % To remove repetitive "Spectral" noise from an image
    % Read a gray scale image
    Image_tif = imread('question_5.tif');
    Image = im2double(Image_tif);
    [row col]=size(Image);
    figure(1), imshow(Image_tif), title('Original Image');
    
    %Determine good padding for Fourier transform 
    PQ = paddedsize([row col]); 

    %Create Notch filters corresponding to extra peaks in the Fourier transform 
    H1 = notchFilter('butterworth', PQ(1), PQ(2), 5, 280, 335); 
    H2 = notchFilter('butterworth', PQ(1), PQ(2), 5, 282, 168); 
    H3 = notchFilter('butterworth', PQ(1), PQ(2), 10, 618, 85); 
    H4 = notchFilter('butterworth', PQ(1), PQ(2), 10, 60, 78); 
    H5 = notchFilter('butterworth', PQ(1), PQ(2), 10, 615, 415); 
    H6 = notchFilter('butterworth', PQ(1), PQ(2), 2, 60, 80); 
    H7 = notchFilter('butterworth', PQ(1), PQ(2), 10, 392, 900); 
    H8 = notchFilter('butterworth', PQ(1), PQ(2), 5, 392, 820); 
    % Calculate the discrete Fourier transform of the image 
    F=fft2(Image,PQ(1),PQ(2)); 

    % Apply the notch filters to the Fourier spectrum of the image 
    FS = F.*H1.*H2.*H3.*H4.*H5.*H6.*H7.*H8; 

    % convert the result to the spacial domain. 
    F_spacial=real(ifft2(FS));  

    % Crop the image to undo padding 
    F_spacial=F_spacial(1:row, 1:col); 
    figure(2), imshow(F_spacial,[]), title('The blurred image'); 

    % Display the Fourier Spectrum   
    Fc=shiftFrequencyToCenter(F); 
    % Move the origin of the transform to the center of the frequency rectangle.
    Fcf=shiftFrequencyToCenter(FS); 

    % abs to compute the magnitude
    % log to brighten display 
    S1=log(1+abs(Fc));  figure(3), imshow(S1,[]), title('Log of Abs of The Fourier Spectrum');  
    S2=log(1+abs(Fcf)); figure(4), imshow(S2,[]), title('Log of Abs of The Centered transformed Image'); 
end
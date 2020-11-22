function Solution4()
    % Read a gray scale image
    Image_tif = imread('question_4.tif');
    Image = im2double(Image_tif);
    [row col]=size(Image);
    figure(1), imshow(Image_tif), title('Original Image');
    
    %Determine good padding for Fourier transform 
    PQ = paddedsize([row col]); 

    %Create high-pass Butterworth filter of the Fourier transform 
    D0 = 60; 
    n = 2;
    H = highpassFilter('butterworth', PQ(1), PQ(2), D0, n); 
    H = fftshift(H);
    % Calculate the discrete Fourier transform of the image 
    F=fft2(Image,size(H,1),size(H,2)); 
    F = fftshift(F);
    
    % Apply the highpass filter to the Fourier spectrum of the image 
    HPFS = H.*F; 
    HPFS = ifftshift(HPFS);
    % convert the result to the spacial domain. 
    HPF_spacialDomain=real(ifft2(HPFS));  

    % Crop the image to undo padding 
    HPF_spacialDomain=HPF_spacialDomain(2:row+1, 2:col+1); 

    % abs to compute the magnitude 
    % log to brighten display 
    S1=log(1+abs(HPF_spacialDomain));  figure(3), imshow(S1,[]), title('Log of Abs of Output image');
    end
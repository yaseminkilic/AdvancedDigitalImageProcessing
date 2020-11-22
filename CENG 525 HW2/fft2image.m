function F = fft2image(imageNameFile)
    img = imread(imageNameFile);
    b = im2double(img);
    figure,imshow(b);title('original image');
    
    % reading the image size
    [m,n] = size(b);
    
    % creating a null array of size 2m X 2n
    c = zeros(2*m,2*n);
    
    % reading the size of the null array
    [p,q] = size(c);
    
    % appdending the original image with the null array to create a padding
    for i = 1:p
        for j = 1:q
            if i <= m && j<= n
                c(i,j) = b(i,j);
            else
                c(i,j) = 0;
            end
        end
    end
    
    % creating a null array of size p X q 
    d = zeros(p,q);
    
    % Multiplying the padded image with (-1)^(x+y)
    for i = 1:p
        for j = 1:q
            d(i,j) = c(i,j).*(-1).^(i + j);
        end
    end
    figure,imshow(d);title('padded image for calculating DFT');
    
    % Computing the 2D DFT using "fft2" matlab command
    F = fft2(d);
end
function Solution2()
    Image_tif=imread('question_2.tif');
    Img=im2double(Image_tif);
    [row col]=size(Image_tif);
    figure(1), imshow(Img), title('Original Image');
    
    hy=[-1 0 1;-2 0 2;-1 0 1];
    hx=[-1,-2,-1;0,0,0;1,2,1];
    %if you don't zero pad the image to a larger size,
    %calculates a correct padding size to avoid this problem
    PQ=paddedsize(size(Image_tif));
    Hy=fft2(double(hy), PQ(1), PQ(2));
    Hx=fft2(double(hx), PQ(1), PQ(2));
    F=fft2(double(Image_tif),PQ(1),PQ(2));
    
    % soble-y
    FDFy=Hy.*F;
    fdf_y=ifft2(FDFy);
    fdf_y=fdf_y(2:row+1, 2:col+1);

    % soble-x
    FDFx=Hx.*F;
    fdf_x=ifft2(FDFx);
    fdf_x=fdf_x(2:row+1, 2:col+1);
    
    %Display results
    figure, subplot(1,2,1),imshow(fdf_x,[]),title('FDF x-Sobel filter','color','r'); 
	subplot(1,2,2),imshow(fdf_y,[]),title('FDF y-Sobel filter','color','r'); 

    %threshold into a binary image
    figure, subplot(1,2,1),imshow(abs(fdf_x) > 0.2*abs(max(fdf_x(:)))),title('For x-Sobel','color','r'); 
	subplot(1,2,2),imshow(abs(fdf_y) > 0.2*abs(max(fdf_y(:)))),title('For y-Sobel','color','r'); 
end
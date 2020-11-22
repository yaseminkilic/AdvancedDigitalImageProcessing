function question5()
    close all;
    R = 255; G = 0; B= 0;
    Image = imread('question_5.tif'); 
    OriginalImg = Image;
    [row, col, n] = size(OriginalImg)
    Output = rgb2hsv(OriginalImg);

    RED = Image(:, :, 1);      %figure, imshow(RED), title('RED');
    GREEN = Image(:, :, 2);    %figure, imshow(GREEN), title('GREEN');
    BLUE = Image(:, :, 3);     %figure, imshow(BLUE), title('BLUE');
    GRAY = rgb2gray(Output);    %figure, imshow(GRAY), title('GRAY');
    
    
    W = 0.1765;
    Rj = [0.6863, 0.1608, 0.1922];
    for mm = 1:size(OriginalImg,1) 
        for nn = 1:size(OriginalImg,2) 
            temp = (im2double(OriginalImg(mm,nn,1))-Rj(1))^2+(im2double(OriginalImg(mm,nn,2))-Rj(2))^2+(im2double(OriginalImg(mm,nn,3))-Rj(3))^2;
            if (temp>W^2)
                OriginalImg(mm,nn,1) = 130;
                OriginalImg(mm,nn,2) = 130;
                OriginalImg(mm,nn,3) = 130;
            end
        end 
    end 
    figure,subplot(1,2,1); imshow(Image,[]);title('Original Image');
    subplot(1,2,2);imshow(OriginalImg,[]);title('Output Image');
end
function Output = question2(image)
    filterSize = 3;
    if nargin == 0
        image=imread('question_2.tif');
        imageMatrix = im2double(image);
    else
        imageMatrix = image;
    end
    [row col]=size(imageMatrix);
    
    Output=image;
    for i=2:row-1
        for j=2:col-1
            mask_array = image(i-1:i+1, j-1:j+1);
            Array=mask_array( : );
            medianResult = median(Array);
            Output(i,j)= medianResult;
        end
    end
    if nargin == 0
        figure, imshow(image), title('Original Image');
        figure, imshow(Output), title(sprintf('%s %dx%d', 'Output Image with', filterSize, filterSize));
        %figure, imshow(medfilt2(image,[filterSize filterSize])), title(sprintf('%s %dx%d', 'Matlab medfilt2() result with', filterSize, filterSize));
    end
end


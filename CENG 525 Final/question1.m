function question1()
    clc,clear all,close all;

    image=imread('question_1.tif');
    imageMatrix = im2double(image);

    filterSize = 15;
    avgByFilterSize = ones(filterSize)/(filterSize*filterSize);
    % Adding padding to borderIndexes
    ImagePadded = padarray(imageMatrix,[1 1]);
    Output = zeros([size(imageMatrix,1) size(imageMatrix,2)]);

    %Convolution
    plusToAvgFilterSize = (filterSize-1);
    for i = 1:size(ImagePadded,1)-plusToAvgFilterSize
        for j = 1:size(ImagePadded,2)-plusToAvgFilterSize
            %Multiply matrix padded with avgByFilterSize 
            Temp = ImagePadded(i:i+plusToAvgFilterSize,j:j+plusToAvgFilterSize).*avgByFilterSize;
            % Sum of them, then update output
            Output(i,j) = sum(Temp(:));
        end
    end
    figure, imshow(image), title('Original Image');
    figure, imshow(Output), title(sprintf('%s %dx%d', 'Output Image with', filterSize, filterSize));
end


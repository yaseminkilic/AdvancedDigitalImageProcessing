function question3(Image)
    if nargin == 0
        Image = imread('question_3.tif');
    end
    imageMatrix = double(Image);
    [row col]=size(imageMatrix);
    newIndexRateToOld = 2
    newRow = row*newIndexRateToOld;
    newCol = col*newIndexRateToOld;

    Output = zeros(newRow,newCol);
    for i=1:newIndexRateToOld:newRow
        for j=1:newIndexRateToOld:newCol
            Output((i:i+newIndexRateToOld-1),(j:j+newIndexRateToOld-1)) = Image(round(i./newIndexRateToOld),round(j./newIndexRateToOld));
        end
    end
    
    if nargin == 0
        figure,subplot(121),imshow(Image);title('Original Image'); axis([0, newRow, 0, newCol]);axis on;
        subplot(122),imshow(uint8(Output));title('Output Image with interpolation to double size(Image)');  axis([0, newRow, 0, newCol]);axis on;
        %figure,imshow(imresize(Image,[newRow newCol],'nearest'));title('Matlab imresize()result to size(image)*2');axis([0, newRow, 0, newCol]);axis on;
    end
end


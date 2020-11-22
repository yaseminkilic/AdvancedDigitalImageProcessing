clear all;
close all; clc;

%----Read image-----
Image_tif=imread('question_2.tif');
figure(1),imshow(Image_tif),title('Original Image');
numofpixels=size(Image_tif,1)*size(Image_tif,2);
%convert RGB image to HSV(HUE Saturation Intensity) format %HSV = rgb2hsv(Image_tif)
HIm=uint8(zeros(size(Image_tif,1),size(Image_tif,2)));
freq=zeros(256,1);
probf=zeros(256,1);
probc=zeros(256,1);
cum=zeros(256,1);
output=zeros(256,1);
%freq => the occurrence of each pixel value
%probf => The probability of each occurrence
for i=1:size(Image_tif,1)
    for j=1:size(Image_tif,2)
        value=Image_tif(i,j);
        freq(value+1)=freq(value+1)+1;
        probf(value+1)=freq(value+1)/numofpixels;
    end
end

sum=0;
no_bins=255;

%The cumulative distribution probability is calculated. 
for i=1:size(probf)
   sum=sum+freq(i);
   probc(i)=sum/numofpixels;
   output(i)=round(probc(i)*no_bins);
end

for i=1:size(Image_tif,1)
    for j=1:size(Image_tif,2)
            HIm(i,j)=output(Image_tif(i,j)+1);
    end
end

figure,imshow(HIm),title('Histogram equalization');
imwrite(HIm, 'Solution2_output.jpeg', 'jpg')

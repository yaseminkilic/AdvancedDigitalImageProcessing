% Power-Law Transformation

clear all;
close all; clc;
% Read a gray scale image
Image_tif = imread('question_1.tif');
Image = im2double(Image_tif);
[row col]=size(Image);

% apply the power-law transform for gamma = 0,4 c = 1
c = 1;
y = 0.4;
for i = 1:row
	for j = 1:col
		s(i,j) = c*(Image(i,j)^y);
	end
end

figure(1), imshow(Image_tif), title('Original Image');
figure(2), imshow(s), title('After Power-Law Transformation Image');
imwrite(s, 'Solution1_output.jpeg', 'jpg')
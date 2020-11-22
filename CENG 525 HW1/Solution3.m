clear all;
close all; clc;

%----Read image-----
Image1=imread('question_3.tif');
Image2=uint8(randi([0, 255],size(Image1, 1),size(Image1, 2))); %%imread('powerLowTransformation_question3.jpeg');
figure(1),imshow(Image1),title('Original Image');
figure(2),imshow(Image2),title('Referans Image');
M = zeros(256, 1, 'uint8'); % Store mapping - Cast to uint8 to respect data type
hist1 = imhist(Image1);     % Compute histograms
hist2 = imhist(Image2);

cdf1 = cumsum(hist1) / numel(Image1); % Compute CDFs (Cumulative Distribution Function)
cdf2 = cumsum(hist2) / numel(Image2);
% Compute the mapping
for idx = 1 : 256
    [~,ind] = min(abs(cdf1(idx) - cdf2)); %~ind => to find non-missing value elements of value
    M(idx) = ind - 1;
end

% apply the mapping to get first image to make
% the image look like the distribution of the second image
out = M(double(Image1) + 1);
figure(3),imshow(out),title('Matched Image');

figure(4);
subplot(2,3,1); imshow(Image1),title('Original Image');
subplot(2,3,2); imshow(Image2),title('Referans Image');
subplot(2,3,3); imshow(out),title('Matched Image');
subplot(2,3,4), imhist(Image1);
subplot(2,3,5), imhist(Image2);
subplot(2,3,6), imhist(out);
imwrite(out, 'Solution3_output.jpeg', 'jpg')

figure(5); imshow(histeq(Image1)),title('Matlab Histeq() Function Output to comparing');
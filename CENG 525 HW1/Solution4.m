clear all;
close all;
clc;

Image_ref=imread('question_4.tif');
a=double(Image_ref);
[row col] = size(a);
Y_Grid=[-1,-2,-1;0,0,0;1,2,1];
X_Grid=[-1 0 1;-2 0 2;-1 0 1];
X=[];
Y=[];
for m=2:1:row-1;
    for n=2:1:col-1;
		Y(m,n)=Y_Grid(1)*a(m-1,n-1) + Y_Grid(2)*a(m-1,n) + Y_Grid(3)*a(m-1,n+1) + Y_Grid(4)*a(m,n-1) + Y_Grid(5)*a(m,n) + Y_Grid(6)*a(m,n+1) + Y_Grid(7)*a(m+1,n-1) + Y_Grid(8)*a(m+1,n) + Y_Grid(9)*a(m+1,n+1);
        X(m,n)=X_Grid(1)*a(m-1,n-1) + X_Grid(2)*a(m-1,n) + X_Grid(3)*a(m-1,n+1) + X_Grid(4)*a(m,n-1) + X_Grid(5)*a(m,n) + X_Grid(6)*a(m,n+1) + X_Grid(7)*a(m+1,n-1) + X_Grid(8)*a(m+1,n) + X_Grid(9)*a(m+1,n+1);
	end  
end
Z = X + Y;

figure(1);imshow(uint8(a));title('ORIGINAL Image','color','r'); 
figure(2);imshow(uint8(X));title('Image By Gx','color','r'); 
figure(3);imshow(uint8(Y));title('Image By Gy','color','r'); 
figure(4);imshow(uint8(Z));title('Image By Gm','color','r'); 
imwrite(uint8(Z), 'Solution4_output.jpeg', 'jpg')
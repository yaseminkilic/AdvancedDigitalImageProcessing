function [X, Y, Z] = sobelMask(imgFile)
    aa=imread(imgFile);
    a=double(aa);
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
    figure(1),imshow(X),title('X Image','color','r'); 
    figure(2),imshow(Y),title('Y Image','color','r'); 
    figure(3),imshow(Z),title('Sum Of X and Y Image','color','r'); 
end


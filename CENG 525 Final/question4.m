function question4()
    close all;
    Image = imread('question_4.tif')
    imageMatrix = im2double(Image);
    [row col]=size(imageMatrix);
    PQ=paddedsize(size(Image));
%--------------------------------------------------------------------------
    H = LowpassFilter('bandbtw', PQ(1), PQ(2), 300,4);
    F=fft2(Image,size(H,1),size(H,2));
    bs_noisy_image= H.*F;
    b_noisy_image=real(ifft2(bs_noisy_image)); 
    b_noisy_image=b_noisy_image(1:row, 1:col);

    Fc=fftshift(F);
    Fcf=fftshift(bs_noisy_image);
    S1=log(1+abs(Fc)); 
    S2=log(1+abs(Fcf));
    figure,subplot(2,2,1); imshow(S1,[]);title('FFT of Noisy Image');
    subplot(2,2,2);imshow(S2,[]);title('BandReject Butterworth Filtered Image');
    subplot(2,2,3);imshow(b_noisy_image, []),title('Inverse FFT');
%----------------
    MedianImage=question2(uint8(b_noisy_image));
    subplot(2,2,4),imshow(MedianImage), title('Median After BandReject Butterworth');
%--------------------------------------------------------------------------
    H = LowpassFilter('btw', PQ(1), PQ(2), 90, 4);
    F=fft2(Image,size(H,1),size(H,2));
    bs_noisy_image= H.*F;
    b_noisy_image=real(ifft2(bs_noisy_image)); 
    b_noisy_image=b_noisy_image(1:row, 1:col);

    Fc=fftshift(F);
    Fcf=fftshift(bs_noisy_image);
    S1=log(1+abs(Fc)); 
    S2=log(1+abs(Fcf));
    figure,subplot(2,2,1); imshow(S1,[]);title('FFT of Noisy Image');
    subplot(2,2,2);imshow(S2,[]);title('Low-pass Butterworth Filtered Image');
    subplot(2,2,3);imshow(b_noisy_image, []),title('Inverse FFT');
%----------------
    MedianImage=question2(uint8(b_noisy_image));
    subplot(2,2,4),imshow(MedianImage), title('Median After Low-pass Butterworth');
%--------------------------------------------------------------------------
%     WienerFilterOutput = WienerFilter(Image, [6 6]);
%     figure, imshow(WienerFilterOutput, []),title('Wiener Filtered Image After Low-pass Butterworth');
%--------------------------------------------------------------------------
%     H1 = Notch('gaussian', PQ(1), PQ(2), 10, 630, 827);
%     H2 = Notch('gaussian', PQ(1), PQ(2), 10, 630, 122);
%     F=fft2(double(Image),PQ(1),PQ(2));
%     FS_noisy_image = F.*H1.*H2;
%     F_noisy_image=real(ifft2(FS_noisy_image)); 
%     F_noisy_image=F_noisy_image(1:row, 1:col);
%     subplot(3,2,6),imshow(F_noisy_image,[]);title('Inverse FFT for Notch Filter')
% 
%     Fc=fftshift(F);
%     Fcf=fftshift(FS_noisy_image);
%     S1=log(1+abs(Fc)); 
%     S2=log(1+abs(Fcf));
%     figure,imshow(S2,[]);title('Notch Filtered Image')
%--------------------------------------------------------------------------
%     H = HighpassFilter('gaussian', PQ(1), PQ(2), 60, 2); 
%     F=fft2(imageMatrix,size(H,1),size(H,2)); 
%     F = fftshift(F);
%     
%     bs_noisy_image= H.*F;
%     b_noisy_image=real(ifft2(bs_noisy_image)); 
%     b_noisy_image=b_noisy_image(1:row, 1:col);
%     figure,subplot(1,3,3);imshow(b_noisy_image, []),title('Inverse FFT')
% 
%     Fc=fftshift(F);
%     Fcf=fftshift(bs_noisy_image);
%     S1=log(1+abs(Fc)); 
%     S2=log(1+abs(Fcf));
%     subplot(1,3,1); imshow(S1,[]);title('FFT of Noisy Image')
%     subplot(1,3,2);imshow(S2,[]);title('High-pass Butterworth Filtered Image')
%--------------------------------------------------------------------------


    function H = Notch(type, M, N, D0, x, y)
        % Generate highpass filter.
        Hlp = HighpassFilter(type, M, N, D0, 1);
        H = circshift(Hlp, [y-1 x-1]);
    end

    function H = HighpassFilter(type, M, N, D0, n)
        if nargin == 4
           n = 1; 
        end
        Hlp = LowpassFilter(type, M, N, D0, n);
        H = 1 - Hlp;
    end
 
    function Output = WienerFilter(img, nhood)
        img = im2double(img);
        if nargin == 1
          nhood = [6 6];
       end
        powHood = (nhood(1)*nhood(2));
        localMean = filter2(ones(nhood), img/powHood);
        localVar = (filter2(ones(nhood), power(img,2))/powHood)-power(localMean,2);
        noise = mean2(localVar);

        Output = img - localMean;
        img = localVar - noise; 
        img = max(img, 0);
        localVar = max(localVar, noise);
        Output = Output ./ localVar;
        Output = Output .* img;
        Output = Output + localMean;
    end

    function H = LowpassFilter(type, M, N, D0, n)
        [U, V] = meshgridFrequency(M, N);
        D = sqrt(U.^2 + V.^2);
        switch type
            case 'ideal'
               H = double(D <=D0);
            case 'btw'
               if nargin == 4
                  n = 1;
               end
               H = 1./(1 + (D./D0).^(2*n));
            case 'bandbtw'
                W=800;
               if nargin == 4
                  n = 1;
               end
               H = 1./(1 + ((D.*W)./((D.^2)-(D0.^2))).^(2*n));
            case 'gaussian'
               H = exp(-(D.^2)./(2*(D0^2)));
            otherwise
                H = 1;
        end
    end

    function [U, V] = meshgridFrequency(M, N)
        u = 0:(M-1);
        v = 0:(N-1);
        idx = find(u > M/2);
        u(idx) = u(idx) - M;
        idy = find(v > N/2);
        v(idy) = v(idy) - N;
        [V, U] = meshgrid(v, u);
    end

    function PQ = paddedsize(AB)
        PQ = 2*AB;
    end
end

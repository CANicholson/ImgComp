clear all
im = imread('U:\com_vision\Images\out_manmade_1k\sun_aawejawauhafqfcc.jpg');
tg = imread('U:\com_vision\Images\mosaic_target1.jpg');


np = 200; % Number of pixel
[m,n,l] = size(im);

%%% Crop tile image to square
if m<n
    imc = imcrop(im,[round((n-m)/2) 1 m-1 m-1]);
else
    imc = imcrop(im,[1 round((m-n)/2) n-1 n-1]);
end
%%%%%%%%

%%% Gaussian smooting and resize twice
img = imgaussfilt(imc,2);
img = imresize(img,np*2/min(m,n));
img = imgaussfilt(img,2);
img = imresize(img,0.5);
img = imcrop(img,[1 1 np-1 np-1]);
%%%%%%

%%% Calculating chi-square distance
h = imhist(img); % Histogram of the tile
h = h./sum(h(:)); %% normalisation

tgf = imcrop(tg,[1 1 np-1 np-1]);
tgh = imhist(tgf); %Histogram of target image
tgh = tgh./sum(tgh(:)); %% normalisation

s = h+tgh;
s(s==0) = 1;
dis1 = 0.5*sum((h-tgh).^2./s); %chi-square distance
%%%%%





figure(1), hold on;
subplot(2,2,1),imshow(im);
subplot(2,2,2),imshow(imc);
subplot(2,2,3),imshow(img);

hold off;
clear all
im = imread('U:\com_vision\Images\out_manmade_1k\sun_aawejawauhafqfcc.jpg');
tg = imread('U:\com_vision\Images\mosaic_target1.jpg');
np = 200; % Number of pixel

tgf = imcrop(tg,[1 1 np-1 np-1]);
img = crop(np,im);
dis1 = calcs(img,tgf);


figure(1), hold on;
subplot(2,2,1),imshow(im);
subplot(2,2,2),imshow(img);

hold off;


function img = crop(np,im)
%%% Gaussian smooting and resize twice
    [m,n,l] = size(im);
    
    img = imgaussfilt(im,2);
    img = imresize(img,np*2/min(m,n));
    img = imgaussfilt(img,2);
    img = imresize(img,0.5);
    [m,n,l] = size(img);
    if m<n
        img = imcrop(img,[round((n-m)/2) 1 np-1 np-1]);
    else
        img = imcrop(img,[1 round((m-n)/2) np-1 np-1]);
    end
end





function chi = calcs(img,tgf)
%%% Calculating chi-square distance
    h = imhist(img); % Histogram of the tile
    h = h./sum(h(:)); %% normalisation

    
    tgh = imhist(tgf); %Histogram of target image
    tgh = tgh./sum(tgh(:)); %% normalisation

    s = h+tgh;
    s(s==0) = 1;
    chi = 0.5*sum((h-tgh).^2./s); %chi-square distance

end










clear all
fname = ['U:\com_vision\Images\out_manmade_1k\sun_aabghtsyctpcjvlc.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_aabwvttncoffagty.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_akzplmxhqavviutt.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_alchntdrksbaiiur.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_alewytlvnsaknhfm.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_algqmkjmqfdlvoyz.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_alhavfbsfrntubql.jpg'
'U:\com_vision\Images\out_manmade_1k\sun_alhfavvprauzwqzo.jpg'];




tg = imread('U:\com_vision\Images\mosaic_target1.jpg'); % Target Image

np = 300;

comp = composite(tg,np,fname);



figure(1), hold on;
subplot(2,2,1),imshow(tg);
subplot(2,2,2),imshow(uint8(comp));
%subplot(2,2,3),imshow(ed);

hold off;


function img = crop(np,im)
%%% Gaussian smooting and resize twice 
    [m,n,l] = size(im);
    
    img = imgaussfilt3(im,2);
    img = imresize(img,np*2/min(m,n));
    img = imgaussfilt3(img,2);
    img = imresize(img,0.5);
    [m,n,l] = size(img);
    if m<n
        img = imcrop(img,[round((n-m)/2) 1 np-1 np-1]);
    elseif m>n
        img = imcrop(img,[1 round((m-n)/2) np-1 np-1]);
    end
end





function chi = calcs(img,tgf)
%%% Calculating chi-square distance between img and tgf

    h = imhist(img); % Histogram of the tile
    h = h./sum(h(:)); %% normalisation

    
    tgh = imhist(tgf); %Histogram of target image
    tgh = tgh./sum(tgh(:)); %% normalisation

    s = h+tgh;
    s(s==0) = 1;
    chi = 0.5*sum((h-tgh).^2./s); %chi-square distance

end



function edw = edgepixel(img)
%%%Calculate number of pixel of edges
    thr = 10;
    sig = 1;
    
    ed = edge(rgb2gray(img),'canny',thr/255,sig);
    ed = imhist(ed); 
    ed = ed./sum(ed(:)); %% normalisation
    edw = ed(2);
end


function comp = composite(tg,np,fname)
%%%Combine composite image
%%%tg = Target Image
%%%np = Number of pixels
%%%fname = List of file name of tiles image

    [tgrp,tgcp,tgl] = size(tg); % tgrp,tgcp : Number of pixel in Row and Column in target image
    
    [fn,fl] = size(fname);                      %Size of file name
    
    nrt = ceil(tgrp/np);                        % Number of tiles in row
    nct = ceil(tgcp/np);                        % Number of tiles in column
    
    for i = 1:fn
        tiles(i).img = crop(np,imread(fname(i,:)));
    end

    comp = [];
    n = 1;                                      %Index of tiles
    for i = 1:nrt
        rimage = [];
        for j = 1:nct
            rimage = [rimage tiles(mod(n,fn)+1).img];
            n = n + 1;          
        end
        comp = [comp;rimage];
    end
    
    comp = imcrop(comp,[1 1 tgcp-1 tgrp-1]);     %Crop composite image to the same size with target image
    
    w = 0.3;                                     %Weight of composite image
    
    comp(:,:,1) = uint8(comp(:,:,1).*w + tg(:,:,1).*(1-w));
    comp(:,:,2) = uint8(comp(:,:,2).*w + tg(:,:,2).*(1-w));
    comp(:,:,3) = uint8(comp(:,:,3).*w + tg(:,:,3).*(1-w));
    %comp = uint8(wfusimg(comp,tg,'db2',1,'mean','mean'));
    
end


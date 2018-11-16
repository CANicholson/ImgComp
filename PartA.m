clear all

%%%%% Load Target Image %%%%%
tgname = loadtargetimage(); %Full path of target image
tg = imread(tgname); % Target Image
[tgrp,tgcp,tgl] = size(tg); % tgrp,tgcp : Number of pixel in Row and Column in target image


%%%%% Load source image %%%%%
fnameload = loadimage('Select Source Image');                %Select folder of source images
[nf mf] = size(fnameload);              

fname_order = randperm(mf);             %Random source image

nt = input('Number of Tiles : ');       %Input number of tiles
np = input('Number of Pixels : ');      %Input number of pixels

fname = {};
for i = 1:nt                            %Choose images to composite from souce images
    fname{i} = fnameload{fname_order(i)};
end

[nf mf] = size(fname);



nrt = ceil(tgrp/np);                    % Number of tiles in row
if nt == nrt                            
    
    
end



while true
    str = input('Do you want to calculate similarity?(y/n)[n]','s');
    if isempty(str)
        str = 'N';
    end
    if or(str == 'n',str == 'N')
        comp = composite_easy(tg,np,fname);
        break;
    elseif or(str == 'y',str == 'Y')
        %edp = [];
        %for i = 1:mf
        %    img = imread(fname(i,:));
        %    edp(i) = edgepixel(img);
        %end
        comp = composite_hard(tg,np,fname);
        break;
    end
end


figure(1), hold on;
subplot(1,2,1),imshow(tg);
subplot(1,2,2),imshow(uint8(comp));
%subplot(2,2,3),imshow(ed);

hold off;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%END MAIN%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function fname = loadimage(str_title)
    %load in folder and sub folders
    start_path = fullfile(matlabroot, 'ImgComp\');
    topLevelFolder = uigetdir(start_path,str_title);
    allSubFolders = genpath(topLevelFolder);
    remain = allSubFolders;
    listOfFolderNames = {};
    while true
        [singleSubFolder, remain] = strtok(remain, ';');
        if isempty(singleSubFolder)
            break;
        end
        listOfFolderNames = [listOfFolderNames singleSubFolder];
    end
    numberOfFolders = length(listOfFolderNames);
    fname = {};
    %iterate through all folder and search for all .mat files
    for k=1: numberOfFolders
        thisFolder = listOfFolderNames{k};
        filePattern = sprintf('%s/*.jpg', thisFolder);
        baseFileNames = dir(filePattern);
        numberOfTrainingFiles = length(baseFileNames);
   
        %iterate through each file, turning them into long vectors and adding
        %them to the dataset
        for f=1 : numberOfTrainingFiles
            fullFileName = fullfile(thisFolder, baseFileNames(f).name);
            fname{f} = fullFileName;
        end
    end
end

function tgname = loadtargetimage()
    [file,path] = uigetfile('*.jpg','Select Target Image');
    if isequal(file,0)
        
    else
        tgname = fullfile(path,file);
        %disp(['User selected ', fullfile(path,file)]);
    end
end


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

function eu = eudis(img,tgf)
%%% Calculate Euclidiean distance between img and tgf
    h = imhist(img); % Histogram of the tile
    h = h./sum(h(:)); %% normalisation

    
    tgh = imhist(tgf); %Histogram of target image
    tgh = tgh./sum(tgh(:)); %% normalisation
    
    eu = sum((h-tgh).^2);

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


function comp = composite_easy(tg,np,fname)
%%%Combine composite image
%%%tg = Target Image
%%%np = Number of pixels
%%%fname = List of file name of tiles image

    [tgrp,tgcp,tgl] = size(tg); % tgrp,tgcp : Number of pixel in Row and Column in target image
    
    [fl,fn] = size(fname);                      %Size of file name
    
    nrt = ceil(tgrp/np);                        % Number of tiles in row
    nct = ceil(tgcp/np);                        % Number of tiles in column
    
    for i = 1:fn
        tiles(i).img = crop(np,imread(fname{i}));
    end

    comp = [];
    n = 1;                                      %Index of tiles
    for i = 1:nrt
        rimage = [];                            %Row images
        for j = 1:nct
            rimage = [rimage tiles(mod(n,fn)+1).img]; %Combine row image
            n = n + 1;          
        end
        comp = [comp;rimage];                   %Combine column image
    end
    
    comp = imcrop(comp,[1 1 tgcp-1 tgrp-1]);     %Crop composite image to the same size with target image
    
    w = 0.3;                                     %Weight of composite image
    
    comp(:,:,1) = uint8(comp(:,:,1).*w + tg(:,:,1).*(1-w));
    comp(:,:,2) = uint8(comp(:,:,2).*w + tg(:,:,2).*(1-w));
    comp(:,:,3) = uint8(comp(:,:,3).*w + tg(:,:,3).*(1-w));
    %comp = uint8(wfusimg(comp,tg,'db2',1,'mean','mean'));
    
end

function comp = composite_hard(tg,np,fname)
%%%Combine composite image by compute similarity of chi-square distance
%%%tg = Target Image
%%%np = Number of pixels
%%%fname = List of file name of tiles image

    [tgrp,tgcp,tgl] = size(tg); % tgrp,tgcp : Number of pixel in Row and Column in target image
    
    [fl,fn] = size(fname);                      %Size of file name
    
    nrt = ceil(tgrp/np);                        % Number of tiles in row
    nct = ceil(tgcp/np);                        % Number of tiles in column
    
    for i = 1:fn
        tiles(i).img = crop(np,imread(fname{i}));
    end

    comp = [];
    n = 1;                                      %Index of tiles
    
    dupck = [];                                 %Duplicate image check
    
    for i = 1:nrt
        rimage = [];                            %Row images
        for j = 1:nct
            
            if i == nrt || j == nct
            %%% Crop target image to find the distance 
            %%% At the edge of target image, extend target image
                tge = [tg imcrop(tg,[1 1 np-1 tgcp-1]);imcrop(tg,[1 1 tgcp-1 np-1]) imcrop(tg,[1 1 np-1 np-1])];
                tgc = imcrop(tge,[1+(i-1)*np 1+(j-1)*np np-1 np-1]);
            else
                tgc = imcrop(tg,[1+(i-1)*np 1+(j-1)*np np-1 np-1]);
            end
                  
                        
            [x y] = size(dupck);                
            if y >= fn                          %If use all of image in tiles, reset them
                dupck = [];
            end
            
            simim = 100;                        %Similarity of Images
            
            for k = 1:fn                        %Choose suitable image from unuse
                if ismember(k,dupck) == 0
                    suitableim = k;
                    break;
                end
            end
            
            for k = 1:fn                        %Find suitable image from less chi-square distance
                simimage = calcs(tgc,tiles(k).img); 
                if simim > simimage && ismember(k,dupck) == 0
                    simim = simimage;
                    suitableim = k;
                end
                
                
            end
            dupck = [dupck suitableim];
            
            
            rimage = [rimage tiles(suitableim).img]; %Combine row image
            n = n + 1;          
        end
        comp = [comp;rimage];                   %Combine column image
    end
    
    comp = imcrop(comp,[1 1 tgcp-1 tgrp-1]);     %Crop composite image to the same size with target image
    
    w = 0.3;                                     %Weight of composite image
    
    comp(:,:,1) = uint8(comp(:,:,1).*w + tg(:,:,1).*(1-w));
    comp(:,:,2) = uint8(comp(:,:,2).*w + tg(:,:,2).*(1-w));
    comp(:,:,3) = uint8(comp(:,:,3).*w + tg(:,:,3).*(1-w));
    %comp = uint8(wfusimg(comp,tg,'db2',1,'mean','mean'));
    
end
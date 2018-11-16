clear all

%%%%% Load Target Image %%%%%
tgname = loadtargetimage(); %Full path of target image
tg = imread(tgname); % Target Image
[tgrp,tgcp,tgl] = size(tg); % tgrp,tgcp : Number of pixel in Row and Column in target image
tgstruc = {tgname};

%%%%% Load KNN model %%%%%
load('lastmodel.mat');  

%%%%% Classify Target Image %%%%%
tgclass = testmodel(tgstruc,1,Mdl); % tgclass.class = 'MM' for Manmade and  'NT' for Natural
t1 = tgclass.class;
t2 = t1{1};

%%%%% Load source image %%%%%
fnameload = loadimage('Select Source Image');                %Select folder of source images
[nf mf] = size(fnameload);              

fname_order = randperm(mf);             %Random source image

%%%%% Get user parameters %%%%%
nt = input('Number of Tiles : ');       %Input number of tiles
np = input('Number of Pixels : ');      %Input number of pixels

i = 1;
n = 1;
fname = {};
while true
    sistruc = {fnameload{i}}; % Source image structure
    siclass = testmodel(sistruc,1,Mdl); % siclass.class = 'MM' for Manmade and  'NT' for Natural
    s1 = siclass.class;
    s2 = s1{1};
    
    
    if t2 == s2
        fname{n} = fnameload{fname_order(i)};
        n = n+1;
        i = i+1;
        if n>nt
            break;
        end
        continue;
    end    
    i = i+1;
end


[nf mf] = size(fname);



nrt = ceil(tgrp/np);                    % Number of tiles in row
if nt == nrt                            
    
    
end


%%%%% Create Composite Image %%%%%
comp = composite_hard(tg,np,fname);
        


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


function opclass = testmodel(fnameload,mf,Mdl)
    tthist = calhistogram2(fnameload,mf);

    ttline = countline(fnameload,mf);

    tthist = [tthist ttline];

    opclass = {};
    for i = 1:mf
        class_type = predict(Mdl,tthist(i,:));
        opclass(i).fname = fnameload{i};
        opclass(i).class = class_type;
        opclass(i).r = tthist(i,1);
        opclass(i).g = tthist(i,2);
        opclass(i).b = tthist(i,3);
        opclass(i).linenum = tthist(i,4);
        %opclass = [opclass;fnameload{i} class_type{i}];
    end
    
    
end




function linenum = countline(fnameload,mf)
    
    linenum = [];
    thr = 30;
    sig = 2;
    for i = 1:mf
        h = imread(fnameload{i});
        BW = edge(rgb2gray(h),'canny',thr/255,sig);
        
        
        %%%% Emphasize line%%%%
        %BW = conv2(BW,ones(3),'same');
        %BW(BW<3) = 0;
        %BW(BW>0) = 1;
        
        [BWx BWy] = size(BW);
        [H,T,R] = hough(BW,'RhoResolution',0.5,'Theta',-90:0.35:89);
        P = houghpeaks(H,300,'Threshold',0.3*max(H(:)),'NHoodSize',[3,3]);
        lines = houghlines(BW,T,R,P);
        plotline = 0;
        for k = 1:length(lines)
            %delete line in edge of piture
            if(abs(lines(k).point1(1)-lines(k).point2(1)) < 10 && (lines(k).point1(1)< 0.1*BWx || lines(k).point1(1) > 0.9*BWx))
                continue;
            end
        
            if(abs(lines(k).point1(2)-lines(k).point2(2)) < 10 && (lines(k).point1(2)< 0.1*BWy || lines(k).point1(2) > 0.9*BWy))
                continue;
            end
            
            c = improfile(BW,[lines(k).point1(1) lines(k).point2(1)],[lines(k).point1(2) lines(k).point2(2)]); %count pixels in line
            [cm cn] = size(c);
            [lcm lcn] = size(c(c==1));
            %delete line that pixel in line < 35%
            if(lcm < 0.35*cm)
                continue;
            end
            
            dis = ((lines(k).point1(1)-lines(k).point2(1))^2 + (lines(k).point1(2)-lines(k).point2(2))^2)^0.5;
        
        
            %delete line length < 5% of maximum side of image
            if(dis < 0.05*max(BWx,BWy)) 
                continue;
            end
        
        
            %delete line that do not have continous segment > 30%
            if(max(conv(c,ones(round(0.3*cm),1))) < round(0.3*cm)-1)
                continue;
            end
            
            
            plotline = plotline +1;
        end
        linenum = [linenum;plotline];
    end

end


function inputhist = calhistogram(fnameload,mf)
    inputhist = [];
    for i = 1:mf
        h = imread(fnameload{i});
        hR = imhist(h(:,:,1));
        hG = imhist(h(:,:,2));
        hB = imhist(h(:,:,3));
        hR = hR./sum(hR(:)); %% normalisation
        hG = hG./sum(hG(:)); %% normalisation
        hB = hB./sum(hB(:)); %% normalisation
        
        inputhist = [inputhist;hR' hG' hB'];
    end
end

function inputhist = calhistogram2(fnameload,mf)
    inputhist = [];
    for i = 1:mf
        h = imread(fnameload{i});
        hR = h(:,:,1);
        hG = h(:,:,2);
        hB = h(:,:,3);
        hR = hR./255; %% normalisation
        hG = hG./255; %% normalisation
        hB = hB./255; %% normalisation
        inputhist = [inputhist;mean(mean(hR)) mean(mean(hG)) mean(mean(hB))];
    end
end

function inputhist = calhistogram3(fnameload,mf)
    inputhist = [];
    for i = 1:mf
        h = imread(fnameload{i});
        hR = imhist(h(:,:,1));
        hG = imhist(h(:,:,2));
        hB = imhist(h(:,:,3));
        hR = hR./255; %% normalisation
        hG = hG./255; %% normalisation
        hB = hB./255; %% normalisation
        
        inputhist = [inputhist;hR' hG' hB'];
    end
end
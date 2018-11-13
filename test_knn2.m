clear all;

%Load manmade
fnameload = loadimage();                %Select folder of source images
[mf nf] = size(fnameload); 
mmcount = mf;

mmhist = calhistogram2(fnameload,mf);

mmline = countline(fnameload,mf);



%Load natural
fnameload = loadimage();                %Select folder of source images
[mf nf] = size(fnameload);
ntcount = mf;

nthist = calhistogram2(fnameload,mf);

ntline = countline(fnameload,mf);



X = [mmhist mmline;nthist ntline];

for i = 1:mmcount
    Y{i} = 'MM';
end

for i = mmcount+1:mmcount+ntcount
    Y{i} = 'NT';
end


Mdl = fitcknn(X,Y,'NumNeighbors',5,'Standardize',1);


%Load test model
fnameload = loadimage();                %Select folder of source images
[mf nf] = size(fnameload); 

tthist = calhistogram2(fnameload,mf);

ttline = countline(fnameload,mf);

tthist = [tthist ttline];

for i = 1:mf
    imclass{i} = predict(Mdl,tthist(i,:));
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%END   MAIN%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function linenum = countline(fnameload,mf)
    
    linenum = [];
    for i = 1:mf
        h = imread(fnameload(i,:));
        BW = edge(rgb2gray(h),'canny');
        [H,T,R] = hough(BW,'RhoResolution',1,'Theta',-90:0.5:89);
        P = houghpeaks(H,100,'Threshold',0.5*max(H(:)),'NHoodSize',[3,3]);
        lines = houghlines(BW,T,R,P);
        plotline = 0;
        for k = 1:length(lines)
            c = improfile(BW,[lines(k).point1(1) lines(k).point2(1)],[lines(k).point1(2) lines(k).point2(2)]); %count pixels in line
            [cm cn] = size(c);
            [lcm lcn] = size(c(c==1));
            if(lcm < 0.22*cm)
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
        h = imread(fnameload(i,:));
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
        h = imread(fnameload(i,:));
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
        h = imread(fnameload(i,:));
        hR = imhist(h(:,:,1));
        hG = imhist(h(:,:,2));
        hB = imhist(h(:,:,3));
        hR = hR./255; %% normalisation
        hG = hG./255; %% normalisation
        hB = hB./255; %% normalisation
        
        inputhist = [inputhist;hR' hG' hB'];
    end
end

function fname = loadimage()
    %load in folder and sub folders
    start_path = fullfile(matlabroot, 'ImgComp\');
    topLevelFolder = uigetdir(start_path);
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
    fname = [];
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
            fname = [fname; fullFileName];
        end
    end
end


function edw = edgepixel(img)
%%%Calculate number of pixel of edges
    thr = 20;
    sig = 2;
    
    ed = edge(rgb2gray(img),'canny',thr/255,sig);
    ed = imhist(ed); 
    ed = ed./sum(ed(:)); %% normalisation
    edw = ed(2);
end
clear all;

while true
    str = input('Do you want to train the model?(y/n)[n]','s');
    if isempty(str)
        str = 'N';
    end
    if or(str == 'n',str == 'N')
        %Load test model
        fnameload = loadimage('Select folder of image to classify');                %Select folder of source images
        [nf mf] = size(fnameload);
        load('lastmodel.mat');
        opclass = testmodel(fnameload,mf,Mdl);
        break;
        
        
    elseif or(str == 'y',str == 'Y')
        %Load manmade
        fnameload = loadimage('Select folder of trainning manmade');                %Select folder of source images
        [nf mf] = size(fnameload); 
        mmcount = mf;

        mmhist = calhistogram2(fnameload,mf);

        mmline = countline(fnameload,mf);



        %Load natural
        fnameload = loadimage('Select folder of trainning natural');                %Select folder of source images
        [nf mf] = size(fnameload);
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
        fnameload = loadimage('Select folder of image to classify');                %Select folder of source images
        [nf mf] = size(fnameload); 
        opclass = testmodel(fnameload,mf,Mdl);
        
        
        break;
    end
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%END   MAIN%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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


function edw = edgepixel(img)
%%%Calculate number of pixel of edges
    thr = 20;
    sig = 2;
    
    ed = edge(rgb2gray(img),'canny',thr/255,sig);
    ed = imhist(ed); 
    ed = ed./sum(ed(:)); %% normalisation
    edw = ed(2);
end
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
numberOfFolders = length(listOfFolderNames)
fname = []
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

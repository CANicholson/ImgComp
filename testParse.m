addpath AD_MCI\
addpath AD_MCI\LH
addpath AD_MCI\RH

%load in folder and sub folders
start_path = fullfile(matlabroot, 'AD_MCI\');
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

%iterate through all folder and search for all .mat files
 for k=1: numberOfFolders
    thisFolder = listOfFolderNames{k};
    filePattern = sprintf('%s/*.mat', thisFolder);
	baseFileNames = dir(filePattern);
    numberOfTrainingFiles = length(baseFileNames);
   
    %iterate through each file, turning them into long vectors and adding
    %them to the dataset
    for f=1 : numberOfTrainingFiles
        fullFileName = fullfile(thisFolder, baseFileNames(f).name);
        load(fullFileName);
        T=cell_tensors{2};    %For accessing time points from the tensor
            for i=1: view_id
                temp = T(:, :, i);
                temp = triu(temp);
                feature_vector = temp(triu(true(size(temp)), 1));
                if i==1
                    view1 = [view1 feature_vector];
                else if i == 3
                    view2 = [view2 feature_vector];
                else if i == 5
                    view3 = [view3 feature_vector];
                else if i == 6
                    view4 = [view4 feature_vector];
                    end
                    end
                    end
                end
            end
                        %update label data to ensure that we know what each vector is
                if f <= 35
                    label_data = [label_data , 1]; % if reading class 1 
                else
                    label_data = [label_data, 0];
                end
      end
 end

 %save all views
 %concatanate all view matrices together 
view1 = view1.';
view2 = view2.';
view3 = view3.';
view4 = view4.';
feature_data = horzcat(view1, view2, view3, view4);
save ('label_dataLH_t2.mat', 'label_data');
save ('67subjectsLH_view1_t2.mat', 'view1');
save ('67subjectsLH_view2_t2.mat', 'view2');
save ('67subjectsLH_view3_t2.mat', 'view3');
save ('67subjectsLH_view4_t2.mat', 'view4');
save ('67subjectsLH_viewall_t2.mat', 'feature_data');

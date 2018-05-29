%clears all the variables in the workspace
clc;
clearvars;

%get a directory of all the files with a suffix P
files = dir('*P.tif');
%%

tic;

%For each file in the folder
for ii = 354:size(files,1)
    
    %get the filename
    I = files(ii).name;
    
    %get the centroids and associated names
    [name1{ii}, centr{ii}, backgr{ii}] = DCC_points(I)
    
    %after getting the name, get the average of each point
    [av_DCC{ii}] = DCC_spotaverage(name1{ii},centr{ii});
    
    %find the geodesic distance transform of the binary image
end

%rearranges everything so that it can save the file
centr = centr';
name1 = name1';
backgr = backgr';
av_DCC =av_DCC';


%nam2 = string(name1); seems useless to have this

%compile everything into a cell/final_data
final_data = cat(2,name1,centr,backgr,av_DCC);

%data is in the variable "final_data". Just open the variable on the right,
%and wala

toc;

%%
for ii = 1:68
    
    %get the filename
    I = files(ii).name;
    
    %get the centroids and associated names
    [name1{ii}, centr{ii}, backgr{ii}] = DCC_points(I)
    
    %after getting the name, get the average of each point
    [av_DCC{ii}] = DCC_spotaverage(name1{ii},centr{ii});
    
end

%% Now to get the means of all the DCC clusters per cell.
for ii = 1:size(files,1)
    
    
    %average all of the DCC cluster means per cell
    [meany{ii}] = mean(av_DCC{ii});

end

%flip the data to make it easier to 
meany = meany';
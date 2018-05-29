function [av_fin] = DCC_spotaverage (I_file,cen)
%takes in a filename and the centroids, then finds the average of the
%detected spot around the centroid.
n = 6;
%% The purpose of this function is to read in a xyt co-ordinates file and get features of an nxn square centered on the centroid of the xyt co-ordinates

tic; %start the timer
tiff_info = imfinfo(I_file); % return tiff structure, one element per image
[pathstr,name, ~] = fileparts(I_file); %get the name

%create the out file name
out_file_s = fullfile(pathstr,[name,'_data_means_',num2str(n),'.csv']);

ROI = [];
ROI_mean = [];
%%
%for 1: length of the csv column

for ii = 1:size(cen,1)
    row_idx = [];
    col_idx = [];
    %read in the time index
 
    %get the centroidz
    col_idx = int64(cen(ii,1));
    row_idx = int64(cen(ii,2));
    %counter for the cells
    count = 1;
    
     
        %read in the frame of the image
        I_f = imread(I_file);
        %get the values of the bounding box
        ROI = I_f((row_idx-floor(n/2)):(row_idx+floor(n/2)),(col_idx-floor(n/2)):(col_idx+floor(n/2)));
        ROI_mean(ii,count) = mean(mean(I_f((row_idx-floor(n/2)):(row_idx+floor(n/2)),(col_idx-floor(n/2)):(col_idx+floor(n/2)))));
        %ROI_SD(ii,count) = std(std(I_f((row_idx-floor(n/2)):(row_idx+floor(n/2)),(col_idx-floor(n/2)):(col_idx+floor(n/2)))));%I is your image. These are the actual pixels.
    count = count+1;
    
end

av_fin = ROI_mean;
%csvwrite(out_file_s,ROI_mean);
toc;


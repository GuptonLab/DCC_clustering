%function centroid_calculation_n (I_file,csv_fil,n)
I_file = 'AVG_488TIRF_18_post_P.tif';
csv_fil = '17_xyt.csv';
n = 6;

%% The purpose of this function is to read in a xyt co-ordinates file and get features of an nxn square centered on the centroid of the xyt co-ordinates

tic; %start the timer
csv = csvread(csv_fil,1,0); %read in the xyt file
tiff_info = imfinfo(I_file); % return tiff structure, one element per image
[pathstr,name, ~] = fileparts(I_file); %get the name
%create the out file name
out_file_s = fullfile(pathstr,[name,'_data_means_',num2str(n),'.csv']);

ROI = [];
ROI_mean = [];
%%
%for 1: length of the csv column

for ii = 1:size(csv,1)
    row_idx = [];
    col_idx = [];
    %read in the time index
 
    %get the centroidz
    col_idx = int64(csv(ii,1));
    row_idx = int64(csv(ii,2));
    %counter for the cells
    count = 1;
    
     
        %read in the frame of the image
        I_f = imread(I_file);
        %get the values of the bounding box
        ROI = I_f((row_idx-floor(n/2)):(row_idx+floor(n/2)),(col_idx-floor(n/2)):(col_idx+floor(n/2)));
        ROI_mean(ii,count) = mean(mean(I_f((row_idx-floor(n/2)):(row_idx+floor(n/2)),(col_idx-floor(n/2)):(col_idx+floor(n/2)))));
        %ROI_SD(ii,count) = std(std(I_f((row_idx-floor(n/2)):(row_idx+floor(n/2)),(col_idx-floor(n/2)):(col_idx+floor(n/2)))));%I is your image. These are the actual pixels.

    
end
csvwrite(out_file_s,ROI_mean);
toc;

%%
I_f = imread(I_file);
mask = logical(imread([name, '_mask_file.tif']));
mean(I_f(mask))
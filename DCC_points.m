function [n centroids background_average] = DCC_points(I_file)  
%This function takes in a DCC expressing cell file and spits out the name
%[n] and the centroids of each detected DCC cluster

%gets the name and path of the file
[pathstr,name, ~] = fileparts(I_file);

%pulls out just the name to associate with the centroids later
n = I_file;

%For the region merging algorithm, sets the parameters (this doesn't really
%ever need to be changed
num_iter = 100;
delta_t = 1/7;
kappa = 30;
option = 2;

% Reads in the associated mask file
I_mask_file = [name, '_mask_file.tif'];
mask = imread(I_mask_file);
mask = logical(mask);

%Reads in the data file
forb = imread(I_file);
ad = imread(I_file);
%figure, imshow(ad,[]);

%performs the region merging using the anisodiff2D function
ad = anisodiff2D(ad,num_iter,delta_t,kappa,option);
%converts the matrix back to greyscale image
ad = mat2gray(ad);
ad = im2uint16(ad);

%figure, imshow(ad,[]);
    
%Get the values of all the pixels in the region-merged image from the mask
pixelsToTest = regionprops(mask,ad, 'PixelValues');

%find the mean and standard deviation of the pixels in the cell
meanP = mean(pixelsToTest(1).PixelValues);
st = std2(pixelsToTest(1).PixelValues);
st2m = meanP+(3*st);
    
%Find only the pixels that are 3 standard deviations away from the mean and
%inside the mask
testFig3 = ad > st2m;

%get the background fluorescence of the cell minus the clusters
%% background fluorescence of the cell
%get the inverse of the clusters mask
inv_clust = ~testFig3;
%figure, imshow(inv_clust,[]);

%multiply the two together
back_mask = immultiply(mask,inv_clust);
%figure, imshow(back_mask,[]);

%use the background mask to get the average pixel intensity of the
%background
backgroundPixels = regionprops(back_mask,forb,'PixelValues');
background_average = mean(backgroundPixels(1).PixelValues);

%%

testFig3 = immultiply(testFig3,ad);
mask = logical(mask);
testFig3 = immultiply(mask,testFig3);

%figure, imshow(testFig3,[]);

%Find all the regional maxima of the detected clusters
BW = imregionalmax(testFig3);
%figure, imshow(BW,[]);

%get the centroids of all the regional maxima to return
stats = regionprops(BW, 'Centroid');
centroids = cat(1, stats.Centroid);
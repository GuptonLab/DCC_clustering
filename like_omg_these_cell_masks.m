%Create the mask for each image file in the directory
tic; %starts a timer
files = dir('*file.tif'); %add in the shared identifier after the *

for ii = 1:size(files,1) %looping through the files in the directory,
    I = files(ii).name; %pick up the name of the iith file:
    I = logical(I);
    %mask_for_DCC(I); %Create a mask file for the image,
    middle_perimeter_mask_creator(I); %Create the middle and perimeter mask files,
end
toc; %tells you how long it took to generate the masks

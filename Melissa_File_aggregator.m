clear;
files = dir('*.txt'); %add in the shared identifier after the *

%get the first values, put it in a table
finalTab = readtable(files(1).name);
finalTab = table2array(finalTab);
%finalTab = finalTab(:,1);

tic; %starts a timer
for ii = 2:size(files,1) %looping through the files in the directory,
    I = files(ii).name; %pick up the name of the iith file:
    table = readtable(I); %read as table
    table = table2array(table); %turn into array
    %colT = table(:,1);
    finalTab =catpad(1,finalTab,table); %Create the middle and perimeter mask files,
end

csvwrite('allData.csv',finalTab);
toc;

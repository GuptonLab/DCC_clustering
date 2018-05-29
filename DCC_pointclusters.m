%read in the example image to threshold
I_file  = 'AVG_488TIRF_18_post_10_P.tif';
I = imread(I_file);
figure, imshow(I,[]);

%gauss filter to remove noise
I2 = imgaussfilt(I,2);
figure, imshow(I2,[]);

%binarize
thresh = multithresh(I2,3);
I3 = imquantize(I2,thresh);
figure, imshow(I3,[]);
%%
  %% FIT gaussian mixture models
    I=im2double(ad);
    K = I(:);

      
    options = statset('Display','final');
    gm = fitgmdist(K,4,'Options',options)
    idx = cluster(gm,K);
    
cluster1 = (idx == 1);
cluster1=reshape(cluster1,size(I));
 
cluster2 = (idx == 2);
cluster2=reshape(cluster2,size(I));
 
cluster3 = (idx == 3);
cluster3=reshape(cluster3,size(I));
 
cluster4 = (idx == 4);
cluster4=reshape(cluster4,size(I));

figure, imshow(cluster1);
figure, imshow(cluster2);
figure, imshow(cluster3);
figure, imshow(cluster4);
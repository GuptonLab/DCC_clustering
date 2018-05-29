%% Testing the imclose,imopen,imdilate,imerode tasks

I_file  = 'AVG_DUP_488TIRF_20_post_10_P.tif';
    s = imread(I_file);
    ad = imgaussfilt(s,2);
    figure, imshow(ad,[]);
        
    se = strel('disk',3);
    Ie = imerode(ad,se);
    ad_mak = imreconstruct(Ie, ad);
    figure, imshow(Ie,[]);
    
    
    %imwrite(ad, out_file_seed, 'Compression','none', 'Writemode', 'append');

    
    %% Base: This does a great job of separating points out and highlighting spots.
    
   num_iter = 100;
   delta_t = 1/7;
   kappa = 30;
   option = 2;
      %title = 'Fabs05_488TIRF_wt_netrin_3_hist_average.tif';

I_file  = 'AVG_DUP_488TIRF_2_post_20_P.tif';
I_mask_file = 'AVG_DUP_488TIRF_2_post_20_P_mask_file.tif';
    ad = imread(I_file);
    add = imread(I_file);
    mask = imread(I_mask_file);
    figure, imshow(ad,[]);
    %ad = imsharpen(ad, 'Radius', 10, 'Amount', 5);
   ad = anisodiff2D(ad,num_iter,delta_t,kappa,option);
   ad = mat2gray(ad);
    ad = im2uint16(ad);
    figure, imshow(ad,[]);


        %Using only the pixels in the cell mask, look at the histogram and
    pixelsToTest = regionprops(mask,ad, 'PixelValues');

    %find the mean and standard deviation of the pixels in the cell
    meanP = mean(pixelsToTest(255).PixelValues);
    st = std2(pixelsToTest(255).PixelValues);
    st2m = meanP+(3*st);
    
    %Find only the pixels that are 4 standard deviations away from the mean
    testFig3 = ad > st2m;
    testFig3 = immultiply(testFig3,ad);
    
    figure, imshow(testFig3,[]);

    BW = imregionalmax(testFig3);
    figure, imshow(BW,[]);
    %%
    stats = regionprops(BW, 'Centroid');
    centroids = cat(1, stats.Centroid);
    %%
    cen = stats.Centroid
    %add = imadjust(add);
    add = uint8(add);
    RGB = insertMarker(add,centroids, 's', 'Color','red','size', 10);
    figure, imshow(RGB,[]);
    figure, imshow(add,[]);
    %%
    figure, imshow(ad,[]);
    se = strel('disk',3);
    Io = imerode(ad, se);
    figure, imshow(Io,[]);
    %%
IM = imreconstruct(testFig3,ad);
figure, imshow(IM,[]);
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
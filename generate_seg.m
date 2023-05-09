%% Output data location
fileoutdata="/Users/aseemjain/Documents/Research/AuditoryCortex/testdata/";
fileoutimagedata="/Users/aseemjain/Documents/Research/AuditoryCortex/testimagedata/";
exportimage="/Users/aseemjain/Documents/Research/AuditoryCortex/exportimage/";
%% Create patches
raw = niftiread('data.nii');
count=0;
for k=1:70
    rawdata=double(raw(:,:,k))/255;
    [x,y]=size(rawdata);
    mid=round([x y]/2);
    for i=-3:3
        for j=-2:2
            centerx=mid(1)+i*512;
            centery=mid(2)+j*512;
            [patch,~]=createwindow(rawdata,[],centery,centerx,512);
            patchname="cor_"+count+"_0000.png";
            imwrite(patch,fileoutdata+patchname)
            count=count+1;
        end
    end
end

%% Run inference on patches(see jupyter notebook script)
%% Restitch patches into image and export
count=0;
imagecount=0;
for k=1:60
    imagetotal=zeros([3297,2697]);
    for i=-3:3
        for j=-2:2
         centery=mid(1)+i*512;
         centerx=mid(2)+j*512;
         test=imread(fileoutimagedata+"cor_"+count+".png");
         imagetotal(centery-512/2:centery+512/2-1,centerx-512/2:centerx+512/2-1)=test;
         %imagesc(test)
         %imagesc(imagetotal)
         count=count+1;
        end
    end
    labeledImage = bwlabel(imbinarize(imagetotal));
    measurements = regionprops(labeledImage, 'Area');
    allAreas = [measurements.Area];
    [biggestArea, indexOfBiggest] = sort(allAreas, 'descend');
    biggestBlob = ismember(labeledImage, indexOfBiggest(1));
    imwrite(biggestBlob>0,exportimage+imagecount+".png");
    imagecount=imagecount+1;

end



%% Read data
fileoutdata="/Users/aseemjain/Documents/Research/AuditoryCortex/Trainingdata/";
fileoutlabel="/Users/aseemjain/Documents/Research/AuditoryCortex/Labeldata/";
%% 
raw = niftiread('data.nii');
label=niftiread('label.nii');
%% 
imshow(double(raw(:,:,59))/255)
imshow(imoverlay(double(raw(:,:,16))/255,double(label(:,:,16))))
%% Extract patches
count=0;
for k=1:60
    rawdata=double(raw(:,:,k))/255;
    labeldata=imbinarize(double(label(:,:,k)));
    [x,y]=size(rawdata);
    mid=round([x y]/2);

    for i=-3:3
        for j=-2:2
            centerx=mid(1)+i*512;
            centery=mid(2)+j*512;
            [patch,labelpatch]=createwindow(rawdata,labeldata,centery,centerx,512);
            if(sum(double(labelpatch(:)))>20000)
                count=count+1;
                patchname="cor_"+count+"_0000.png";
                lablename="cor_"+count+".png";
                labelpatch = rescale(labelpatch,0,255);
                labelpatch(labelpatch>0)=1; 
                imwrite(patch,fileoutdata+patchname)
                imwrite(uint8(labelpatch),fileoutlabel+lablename)
                %disp('test')
            end
        end
    end
end

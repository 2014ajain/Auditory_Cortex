%% Read data
raw = niftiread('data.nii');
exportimage="/Users/aseemjain/Documents/Research/AuditoryCortex/exportimage/";
%%
fileoutdata="/Users/aseemjain/Documents/Research/Auditory Cortex/Transformeddata/";

%% 
[optimizer, metric] = imregconfig ('monomodal');
optimizer.MaximumIterations = 400;
optimizer.MinimumStepLength = 5e-4;
    %%
for i=2:60
    if(i==2)
        fixeddata=imresize(raw(:,:,1),.1);
        fixeddata=double(fixeddata)/255;
  
    end

    movingdata=imresize(raw(:,:,i),.1);
    movingdata=double(movingdata)/255;

    labeldata=imread(exportimage+i+".png");
    registeredim = imregister (movingdata, fixeddata, 'affine', optimizer, metric);
    registeredt = imregtform (movingdata, fixeddata, 'affine', optimizer, metric);
    labelregister = imwarp(labeldata,registeredt,"OutputView",imref2d(size(movingdata)));
    fixeddata=registeredim;
    imwrite(labelregister,fileoutdata+i+".png")

end
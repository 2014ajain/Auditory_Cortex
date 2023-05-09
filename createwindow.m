function [cropim,croplabel]=createwindow(RGB,label,centerx,centery,size)
    cropim=RGB(centery-size/2:centery+size/2-1,centerx-size/2:centerx+size/2-1,:); 
    if(~isempty(label))
        croplabel=label(centery-size/2:centery+size/2-1,centerx-size/2:centerx+size/2-1); 
    else
        croplabel=[];
    end
    
   % imshow(imoverlay(cropim,croplabel))

end
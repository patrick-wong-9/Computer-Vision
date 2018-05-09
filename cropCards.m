function [croppedIm] = cropCards (grayIm, H, sigma, size)
    %% Cropping singular test images from TRANSFORMED images
    %grayIm     - grayscale image
    %H          - Three 3x3 homographys for L, center, R cards
    %transIm    - transformed image
    %size       - desired size of cropped image
    %---------------------------------------------------------------------
    %croppedIm --> spits out the 3 cropped gray images (cards) from test image
    
    croppedIm = cell(1,3);
    %id is card number
    for id = 1:3
        %compute transformation matrix
        T = maketform('projective', H(:,:,id)');
        %transform image
        [transIm,~,~]=imtransform(grayIm,T);
        
        BinTrans = imbinarize(imgaussfilt(transIm, sigma));
        %BinTrans = imbinarize(transIm);
        %crop to get rid of noise, assume cards are centered
        BinTrans = BinTrans(1:600,1:end);
        %get contour for aid in finding corners
        [tCoord,~] = bwboundaries(edge(BinTrans,'canny'));
        %harris detector to find corners
        tCorners = getCardVertex(transIm, tCoord);
        
        %% only to debug, proves gauss filter is necessary
%         figure
%         imshow(BinTrans)
%         figure
%         imshow(transIm);
%         hold on
%         for ID = 1:3
%             for i = 1:4
%                 pts = tCorners(:,:,ID);
%                 plot(pts(1,i), pts(2,i), 'rx')
%             end
%         end
%         
        %%
        c = tCorners(:,:,id);
        temp = transIm(c(2,3):c(2,2),c(1,1):c(1,2));
        croppedIm{id} = imresize(temp, size);
    end
end
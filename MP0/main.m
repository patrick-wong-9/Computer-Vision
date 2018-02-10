% CS 543 Assignment 1, starter Matlab code
% Adapted from A. Efros
% (http://graphics.cs.cmu.edu/courses/15-463/2010_fall/hw/proj1/)
clear all 
close all
tic
% name of the input file
imname = '00125v.jpg';

% read in the image
fullim = imread(imname);

% convert to double matrix (might want to do this later on to same memory)
fullim = im2double(fullim);

% compute the height of each part (just 1/3 of total)
height = floor(size(fullim,1)/3);
width = size(fullim,2);

% high res images
window = 64;
scale = 16;

% low res
if(height < 2000 || width < 2000)
    window = 64;
    scale = 1; 
end

% separate color channels
B = fullim(1:height,:);
G = fullim(height+1:height*2,:);
R = fullim(height*2+1:height*3,:);

% resizing 
sB = imresize(B, 1/scale);
sG = imresize(G, 1/scale);
sR = imresize(R, 1/scale); 
trans = [0, 0];
%% aligning to BLUE
%{
greenVec = IMG_Pyramid(scale,window,sG,sB,trans);
redVec = IMG_Pyramid(scale,window,sR,sB,trans);
aR = circshift(R, redVec);
aG = circshift(G, greenVec);
startR = 1; startC = 1; endR = 0; endC = 0;

%cropping borders due purely to shifts
if(greenVec(1)>0 || redVec(1) > 0)
    startR = max(greenVec(1),redVec(1));
end
if(greenVec(2)>0 || redVec(2) > 0)
    startC = max(greenVec(2),redVec(2));
end
if(greenVec(1)<0 || redVec(1) < 0)
    endR = min(greenVec(1),redVec(1));
end
if(greenVec(2)<0 || redVec(2) < 0)
    endC = min(greenVec(2),redVec(2));
end

shiftedIMG = cat(3, aR, aG, B); 
croppedIMG = cat(3, aR(startR:height+endR,startC:width+endC),aG(startR:height+endR,startC:width+endC),B(startR:height+endR,startC:width+endC));
figure
imshow(shiftedIMG)
figure
imshow(croppedIMG)
stop = toc

%}


%aligning to RED
blueVec = IMG_Pyramid(scale,window,sB,sR,trans);
greenVec = IMG_Pyramid(scale,window,sG,sR,trans);
aB = circshift(B, blueVec);
aG = circshift(G, greenVec);
startR = 1; startC = 1; endR = 0; endC = 0;
%cropping borders due purely to shifts
if(greenVec(1)>0 || blueVec(1) > 0)
    startR = max(greenVec(1),blueVec(1));
end
if(greenVec(2)>0 || blueVec(2) > 0)
    startC = max(greenVec(2),blueVec(2));
end
if(greenVec(1)<0 || blueVec(1) < 0)
    endR = min(greenVec(1),blueVec(1));
end
if(greenVec(2)<0 || blueVec(2) < 0)
    endC = min(greenVec(2),blueVec(2));
end

shiftedIMG = cat(3, R, aG, aB); 
croppedIMG = cat(3, R(startR:height+endR,startC:width+endC),aG(startR:height+endR,startC:width+endC),aB(startR:height+endR,startC:width+endC));
figure
imshow(shiftedIMG)
figure
imshow(croppedIMG)
stop = toc
%}

%% aligning to GREEN

%{
blueVec = IMG_Pyramid(scale,window,sB,sG,trans);
redVec = IMG_Pyramid(scale,window,sR,sG,trans);
aB = circshift(B, blueVec);
aR = circshift(R, redVec);

startR = 1; startC = 1; endR = 0; endC = 0;
if(blueVec(1)>0 || redVec(1) > 0)
    startR = max(blueVec(1),redVec(1));
end
if(blueVec(2)>0 || redVec(2) > 0)
    startC = max(blueVec(2),redVec(2));
end
if(blueVec(1)<0 || redVec(1) < 0)
    endR = min(blueVec(1),redVec(1));
end
if(blueVec(2)<0 || redVec(2) < 0)
    endC = min(blueVec(2),redVec(2));
end

shiftedIMG = cat(3, aR, G,aB) ; 
croppedIMG = cat(3, aR(startR:height+endR,startC:width+endC),G(startR:height+endR,startC:width+endC),aB(startR:height+endR,startC:width+endC));
figure
imshow(shiftedIMG)

figure
imshow(croppedIMG)
stop = toc
%}

% CS 543 Assignment 1, starter Matlab code
% Adapted from A. Efros
% (http://graphics.cs.cmu.edu/courses/15-463/2010_fall/hw/proj1/)
tic
% name of the input file
imname = '01861a.tif';

% read in the image
fullim = imread(imname);

% convert to double matrix (might want to do this later on to same memory)
fullim = im2double(fullim);

% compute the height of each part (just 1/3 of total)
height = floor(size(fullim,1)/3);
width = size(fullim,2);
window = 50;
s = .125;

% separate color channels
B = fullim(1:height,:);
G = fullim(height+1:height*2,:);
R = fullim(height*2+1:height*3,:);
%%
%implement recurisve func calls !!!
sB = imresize(B, s);
sG = imresize(G, s);
sR = imresize(R, s);

% find center of color channel
centH= floor(size(sG,1)/2);
centW = floor(size(sG,2)/2); 
%greenVec = IMG_Pyramid(8,window,G,B,centH,centW);
%redVec = IMG_Pyramid(8,window,R,B,centH,centW);


% trim color channels to critical area
cG = G(centH-window:centH+window, centW-window:centW+window);
cR = R(centH-window:centH+window, centW-window:centW+window);
cB = B(centH-window:centH+window, centW-window:centW+window);

% Align the images
% Functions that might be useful to you for aligning the images include: 
% "circshift", "sum", and "imresize" (for multiscale)
bCvector = alignIMG_center(cB,cG,window,[0,0])/scale;
rCvector = alignIMG_center(cR,cG,window,[0,0])/scale;
disp(bCvector)
aB = circshift(B, bCvector);
aR = circshift(R, rCvector);


% open figure
%% figure(1);
figure(1)

% create a color image (3D array)
% ... use the "cat" command
% show the resulting image
% ... use the "imshow" command
% save result image
%shiftedIMG = cat(3,aR( (3:height), (8:width)),aG( (3:height), (8:width)),B( (3:height), (8:width)));


shiftedIMG = cat(3,aR, G, aB); 
imshow(shiftedIMG)
stop = toc


%% imwrite(colorim,['result-' imname]);


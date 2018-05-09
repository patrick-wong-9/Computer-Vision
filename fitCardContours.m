%function contouredIm = fitCardCountours(im, sigma)
clear all;
path = 'C:/Users/Patrick Wong/Documents/MATLAB/COMPUTER VISION/Final Project/Final Project Dataset/';
testpath = 'C:/Users/Patrick Wong/Documents/MATLAB/COMPUTER VISION/Final Project/Test Images/';
testImgNum = 1:1:18; %indices of test images
%imshow(imresize(imread([path,'Q_spades.JPG']),1/4 ))


%for imgNo = 1:size(testImgNum,2)
imgNo = 1;
fullPath = [testpath,'Test_', int2str( testImgNum(imgNo) ), '.JPG'];

sigma = [8, 8];
th = 500; %helps single out card contours (works for 1-10 test images, 11 has issues)

%change full path to im when converting to function
testIm = imread(fullPath);
grayIm = rgb2gray(testIm);
grayIm = imresize(grayIm, 1/4);%resize for faster processing...
blurIm = imgaussfilt(grayIm, sigma);

BinIm = imbinarize(blurIm);         %binarizes the image
BWedge = edge(BinIm, 'canny');      %converts to edge image
[coord, L] = bwboundaries(BWedge);  %pixels of contour

%% write function to find points closet to contours

corners = getCardVertex(grayIm, coord);

%% confirming h_corners (note,
figure
imshow(grayIm);
hold on
for ID = 1:3
    for i = 1:4
        pts = corners(:,:,ID); 
        plot(pts(1,i), pts(2,i), 'rx')
        % %     ind = hc_ind(i);
        %      plot(bound(hc_ind(i),2), bound(hc_ind(i),1), 'rx');
        %      hold on
    end
end





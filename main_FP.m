%% main function for Card Detection/Recongition
% written by Patrick Wong
% cs543 final project

clear all;
close all;
tic

testpath = 'C:/Users/Patrick Wong/Documents/MATLAB/COMPUTER VISION/Final Project/Test Images/';
testImgRange = 1:1:18; %indices of test images

%for imgNo = 1:size(testImgRange,2)
  imgNo =8;   
    %% Preprocessing
    
    fullPath = [testpath,'Test_', int2str( testImgRange(imgNo) ), '.JPG'];
    sigma = [8, 8];
    
    testIm = imread(fullPath);
    grayIm = rgb2gray(testIm);
    grayIm = imresize(grayIm, [756,1008]);%resize for faster processing...
    blurIm = imgaussfilt(grayIm, sigma);
    
    BinIm = imbinarize(blurIm);         %binarizes the image
    BWedge = edge(BinIm, 'canny');      %converts to edge image
    [coord, L] = bwboundaries(BWedge);  %pixels of contour
    
    % figure
    % imshow(grayIm)
    % hold on;
    % for i = 1:3
    %     pts = coord{i};
    %     plot(pts(:,2),pts(:,1),'r', 'LineWidth', 2)
    % end
    %% Get Verticies of Cards
    corners = getCardVertex(grayIm, coord);
    
    %% Find Perspective Transformation Matrix (Homography), H
    H = zeros(3,3,3);
    for i = 1:3
        H(:,:,i) = homography(corners(:,:,i) );
    end
    
    %% Plotting corners
    %         figure
    %         imshow(grayIm);
    %         hold on
    %         for ID = 1:3
    %             for i = 1:4
    %                 pts = corners(:,:,ID);
    %                 plot(pts(1,i), pts(2,i), 'rx')
    %             end
    %         end
    %     hold on
    %     for bd = 1:3
    %        bound = coord{bd};
    %        plot(bound(:,2), bound(:,1))
    %        hold on
    %     end
    
    %% CROPPING transformed image  (all size 525, 375)
    savePath = 'C:/Users/Patrick Wong/Documents/MATLAB/COMPUTER VISION/Final Project/Results/BinAndCropped/';
    size = [525, 375];
    % contains a 1x3 cell for each card
    croppedIms= cropCards(grayIm, H, sigma, size);
    
    %---------------------- for saving output images --------------------------
    %     figure;
    %     for i = 1:3
    %         subplot(1,3,i)
    %         imshow(imbinarize(croppedIms{i}))
    %         hold on;
    %     end
    %     saveas(gcf,[savePath,'TestImg_',int2str(imgNo),'.png'])
    
    %% Suit and Rank Extraction
    rankTempSize = [90,60];     %rank template size
    suitTempSize = [90,75];    %suit template size
    for i = 1:3
        [rank, suit] = suitAndRank(croppedIms{i});
        figure
        subplot(1,2,1)
        imshow(rank)
        subplot(1,2,2)
        imshow(suit)
        %% SSD
        [bestSuit(imgNo,i), bestRank(imgNo,i)] = slidingTemplate(rank, suit, rankTempSize, suitTempSize, imgNo);
    end
    

toc


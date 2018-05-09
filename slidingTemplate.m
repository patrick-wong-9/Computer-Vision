function [bestSuit, bestRank] = slidingTemplate(rank, suit, rankTempSize, suitTempSize, imgNo)
    path = 'C:/Users/Patrick Wong/Documents/MATLAB/COMPUTER VISION/Final Project/Processed Templates/';
    RANKS = ['2', '3', '4', '5', '6', '7', '8', '9', 'T', 'J', 'Q', 'K', 'A'];
    SUITS = ['S', 'H', 'D', 'C']; %spades, hearts, diamonds, and clubs
    
    %% RANKS
    
    rankSSD = zeros(1,13);
    %   resize image
    rank = (imresize(rank,rankTempSize));
    %   comparing ranks
    for i = 1:13
        %binarize the templates to 0s and 1s
        temp = imbinarize(imread([path,RANKS(i),'_processed.JPG']));
        [rankSSD(i),d] = alignIMG(double(rank),double(temp), 2);
    end
    
    [~,I] = min(rankSSD);
    bestRank = string(RANKS(I));
    % uncomment to plot overlayed template and cropped rank
    shifted = circshift(double(rank), [d]);
    X = double(shifted) - double(imbinarize(imread([path,RANKS(I),'_processed.JPG'])));
    figure
    subplot(1,2,1)
    imshow(X)
    
    
    %% SUITS
    
    suitSSD = zeros(1,4);
    %   resize image
    suit = (imresize(suit,suitTempSize));
    %   comparing suits
    for i = 1:4
        %binarize the templates to 0s and 1s
        temp = imbinarize(imread([path,SUITS(i),'_processed.JPG']));
        [suitSSD(i), d] = alignIMG(double(suit), double(temp), 2);
    end
    
    [B,I] = min(suitSSD);
    bestSuit = string(SUITS(I));
    % uncomment to plot overlayed template and cropped suit
    shifted = circshift(double(suit), [d]);
    X = double(shifted) - double(imbinarize(imread([path,SUITS(I),'_processed.JPG'])));
    subplot(1,2,2)
    imshow(X)
    
    
end
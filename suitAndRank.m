%% Rank Extraction
function [rank, suit] = suitAndRank(im)
    %returns the cropped rank and suit images
    %----------------------------------------------------------------------
    %makes rank all 1s and white background card 0s
    binIm = imcomplement(imbinarize(im));
    %% rank extraction
    rank = binIm(8:110, 8:85);
    %find left and right most pixel and top and bottom most pixel to crop
    %even more
    [row, col] = find(rank == 1);
    rank = rank(min(row):max(row), min(col):max(col));
    
    %% suit extraction
    suit = binIm(120:220, 1:85);
    [row,col] = find(suit == 1);
    suit = suit(min(row):max(row), min(col):max(col));
    
end
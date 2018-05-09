%%Preprocess templates
rankTempSize = [90,60];     %rank template size
suitTempSize = [90,75];    %suit template size
template = 'C:/Users/Patrick Wong/Documents/MATLAB/COMPUTER VISION/Final Project/Templates/';
savePath = 'C:/Users/Patrick Wong/Documents/MATLAB/COMPUTER VISION/Final Project/Processed Templates/';
%% processing rank templates

RANKS = ['2', '3', '4', '5', '6', '7', '8', '9', 'T', 'J', 'Q', 'K', 'A'];
for i = 1:13
    rankPath = [template,RANKS(i),'.PNG'];
    temp = imcomplement(imbinarize(rgb2gray(imread(rankPath))));
    [row,col] = find(temp == 1);
    temp = temp(min(row):max(row), min(col):max(col));
    temp = imresize(temp, rankTempSize);   
    imwrite(temp, [savePath,RANKS(i),'_processed.JPG'])
    
end
%% processing suit templates

SUITS = ['S', 'H', 'D', 'C'];
for i = 1:4
    suitPath = [template,SUITS(i),'.PNG'];
    temp = imcomplement(imbinarize(rgb2gray(imread(suitPath))));
    [row,col] = find(temp == 1);
    temp = temp(min(row):max(row), min(col):max(col));
    temp = imresize(temp, suitTempSize);
    imwrite(temp, [savePath,SUITS(i),'_processed.JPG'])
end

function [ blokz, numBlocks ] = blockArray(x, windowSize, hopSize)
%blockArray defines all of the blocks
%   block # = column number

numBlocks = ((length(x)- mod(length(x),hopSize))/hopSize);
pad = zeros(windowSize,1);
x = [x;pad];
blokz = zeros(windowSize,numBlocks);
blockA = zeros(windowSize,1);
for n = 1:numBlocks
    iStart = (n-1)*hopSize+1;
    iEnd = iStart + windowSize - 1;
     
    blockA = x(iStart:iEnd);                         
    blokz(:,n) = blockA(:,1);

end
end


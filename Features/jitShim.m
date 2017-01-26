function [jitter, shimmer] = jitShim(x, fs )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%pitch tracker
iBlockLength = 1048;
iHopLength = 512;
[f, t] = PitchTimeAcf(x, iBlockLength, iHopLength, fs);
f = mean(f);

%convert pitch to period length (samples/cycle)
spc = fs/f;
if mod(round(spc), 2) == 0 %round to nearest even int
   spc = round(spc);
elseif mod(ceil(spc), 2) == 0
   spc = ceil(spc);
    elseif mod(floor(spc),2) == 0
            spc = floor(spc);
end

%Phase Offset
[~,firstPeak] = max(x(1:spc));
N = 2;%number of neighbors
x = x(floor(firstPeak+(spc/2)):floor(firstPeak+(spc/2)+spc*(floor(length(x)/spc)-N)));

numBlocksEst = floor(length(x)/spc);%this gives an overestimate for some reason..
storePPQ = zeros(1,numBlocksEst);
storeAPQ = zeros(1,numBlocksEst);

iStart = 1;
iEnd = 1;
windowSize = (2*N+2)*spc;
    %hopSize = spc;
    debugMat = zeros(1,300);
    n = 1;
while iEnd <= length(x)-windowSize
    debugMat(n) = iStart;
    iEnd = iStart + windowSize - 1;
    block = x(iStart:iEnd);  
    [ppq, apq, iStart]=perturbation( block, N, spc, iStart);
    storePPQ(n) = ppq;
    storeAPQ(n) = apq;
    n = n+1;
end
storePPQ = storePPQ(N+1:n-1);
storeAPQ = storeAPQ(N+1:n-1);
jitter = mean(storePPQ);%maybe variance can be an indicator in addition to mean?
shimmer = mean(storeAPQ);
if shimmer >= 100
    shimmer = 0;
end
frequency = f;
%plot
% subplot(3,1,1)
% plot(x)
% xlabel({'Samples'});
% ylabel({'Normalized Amplitude'});
% title({'Waveform'});
% 
% subplot(3,1,2)
% plot(storePPQ)
% xlabel({'Blocks'});
% ylabel({'PPQ'});
% title({'Jitter'});
% 
% subplot(3,1,3)
% plot(storeAPQ)
% xlabel({'Blocks'});
% ylabel({'APQ'});
% title({'Shimmer'});
end


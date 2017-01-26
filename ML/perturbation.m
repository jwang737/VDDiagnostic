function [ ppq, apq, iStart ] = perturbation( block, N, spc, iStart )
%UNTITLED2 Summary of this function goes here
%   http://www.fon.hum.uva.nl/praat/manual/Voice_2__Jitter.html
%   http://www.fon.hum.uva.nl/praat/manual/Voice_3__Shimmer.html

peakHeight = zeros(1, 2*N+2);
peakIndex = zeros(1, 2*N+2);
for n = 1:2*N+2
    startIndex = (n-1)*spc+1;
    endIndex = startIndex + spc - 1;
    cycle = block(startIndex:endIndex);  
    [peakHeight(n), peakIndex(n)] = max(cycle);
    peakIndex(n) = peakIndex(n)+startIndex-1;
end

%ppq
periodDiff = zeros(1, 2*N+1);
for n = 2:2*N+2
    periodDiff(n-1) = abs(peakIndex(n)-peakIndex(n-1));
end
ppq = abs((periodDiff(N+1)-mean(periodDiff)))/mean(periodDiff);
iStart = floor(iStart+mean(peakIndex(1:2)));
%apq
peakHeight = peakHeight(1:2*N+1);
apq = abs((peakHeight(N+1)-mean(peakHeight))/mean(peakHeight));

end 
function [ FFTArray ] = rawFFT( x )
% takes segments from segmentArray and calculates the raw FFT for each
% segment. Outputs a 15 x numBins array to be catenated with 15xnumBins
% arrays of other keys

FFTArray = abs(fft(x))';% default 176 - yields best results

%delete first bin
FFTArray = FFTArray(:,2:end);
end


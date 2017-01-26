function [mfccArray ] = featureExtraction2(x, fs)
%getFeatures
%   This function computes FFT and MFCC features for the dataset passed to
%   it. Functions to detect the keystroke onsets and segment the audio are
%   called. Features are extracted from small segments of audio, tiny
%   snippets of the key being pressed. The function returns both features
%   matrices for the particular dataset

    %Initializing feature matrices
    %TotalFFTArray = [];
    %mfccArray = [];
    %TotalJitArray = [];
    %TotalShimArray = [];
    
        x = x / max(abs(x));

        %Feature extraction
            mfccArray = ComputeFeature('SpectralMfccs', x, fs);% this returns 13 MFCCs for each time step.
            mfccArray = mean(mfccArray, 2); % this takes the average of the MFCCs over all time steps [13,1]
            mfccArray = mfccArray';
            %Pass segments into Jitter/Shimmer
%             [jitter, shimmer] = jitShim(x, fs);
%             TotalJitArray = [TotalJitArray; jitter];
%             TotalShimArray = [TotalShimArray; shimmer];

end



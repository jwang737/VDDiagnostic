function [TotalFeatArray] = featureExtraction(filenameArray)
%getFeatures
%   This function computes MFCC, jitter and shimmer features for the dataset passed to
%   it. Functions to detect the keystroke onsets and segment the audio are
%   called. The function returns features'
%   matrices for the particular dataset

    %Initializing feature matrix
    TotalFeatArray = [];
    %Audiofile directory
    cd('/Users/jonathanwang/Desktop/7100 /VDDiagnostic/Audio')
    %Read in audio files
    for filenumber = 1:length(filenameArray)%for each file
        filename = filenameArray{filenumber};%read in filename
        [x,fs] = audioread(filename); % read file

        %Normalizing audio
        x = x / max(abs(x));

        %Feature extraction
        featureVector = [];
            %Pass segments into MFCC, return featureMFCC
            mfccArray = ComputeFeature('SpectralMfccs', x, fs);% this returns 13 MFCCs for each time step.
            mfccArray = mean(mfccArray, 2); % this takes the average of the MFCCs over all time steps [13,1]
            mfccArray = mfccArray'; %create one row of MFCCs for each file [nFiles, 13]
            featureVector = [featureVector, mfccArray];
            %Pass segments into Jitter/Shimmer
            [jitter, shimmer] = jitShim(x, fs);
            featureVector = [featureVector, jitter, shimmer];
            TotalFeatArray = [TotalFeatArray; featureVector]; 
            
            
%              
%              TotalJitArray = [TotalJitArray; jitter];
%              TotalShimArray = [TotalShimArray; shimmer];

    end
end



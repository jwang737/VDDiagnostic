% Initialize Results
Results = [];
%Store audiofile names
[training, testing]  = getFileNames();
%[training, testing]  = getFileNames();

%TRAINING
    %Feature Extraction
    cd('/Users/jonathanwang/Documents/MATLAB/7100/ML/Audio/Training')
    [FEAT] = featureExtraction(training); %training set

%Record Audio
    [ x, fs ] = recordVoice(1, 44100);
    %save(file, x);
    cd('/Users/jonathanwang/Documents/MATLAB/7100/ML/Audio/Recorded')
    voiceFile = 'voiceFile.wav';
    audiowrite(voiceFile, x, fs);
    [FEATR] = featureExtraction2(x, fs); 
    
%TESTING
    %Feature Extraction
    cd('/Users/jonathanwang/Documents/MATLAB/7100/ML/Audio/Testing')
    %load ground truth for training set
    load('/Users/jonathanwang/Documents/MATLAB/7100/ML/disorderTruth.mat')
    %load ground truth for test set
    load('/Users/jonathanwang/Documents/MATLAB/7100/ML/testSetTruth.mat')
    
% Define Test File
   
disorderTruth = [1 1 1 2 2 2 2 2 3 3 3 3 3 3 3 4 4 4 4 4];
    % Define Testng Set (For Evaluation and optimizing)

    %Test Set
    [FEATT] = featureExtraction(testing);
    
    %Classification
    %Natural FFT
    %natFFTNN = nueralNet(FFTN,trainingTruth,FFTS,FFTT1,FFTT2,FFTT3,FFTT4, brandonTruth, foxTruth, jonnyTruth);
    Lin = linearClassifier(FEAT,disorderTruth,FEATT);%third input should be MFCCR' for recorded
    Knn = kNN(FEAT,disorderTruth,FEATT);%third input should be MFCCR' for recorded
    validateLin = Lin;
    validateKnn = Knn;
    %You_Might_Have = Lin
    %combined training
%     FFTC = [FFTN;FFTS];
%     MFCCC = [MFCCN; MFCCS];
%     trainingTruth = [trainingTruth;trainingTruth];

    %Combined FFT
%     comFFTNN = nueralNet(FFTC,trainingTruth,FFTS,FFTT1,FFTT2,FFTT3,FFTT4, brandonTruth, foxTruth, jonnyTruth);
%     comFFTLin = linearClassifier(FFTC,trainingTruth,FFTS,FFTT1,FFTT2,FFTT3,FFTT4, brandonTruth, foxTruth, jonnyTruth);
%     comFFTKnn = kNN(FFTC,trainingTruth,FFTS,FFTT1,FFTT2,FFTT3,FFTT4, brandonTruth, foxTruth, jonnyTruth);
    
    %Combined MFCC (we tried this, but results were worse)
%     comMFCCNN = nueralNet(MFCCC,trainingTruth,MFCCS,MFCCT1,MFCCT2,MFCCT3,MFCCT4, brandonTruth, foxTruth, jonnyTruth);
%     comMFCCLin = linearClassifier(MFCCC,trainingTruth,MFCCS,MFCCT1,MFCCT2,MFCCT3,MFCCT4, brandonTruth, foxTruth, jonnyTruth);
%     comMFCCKnn = kNN(MFCCC,trainingTruth,MFCCS,MFCCT1,MFCCT2,MFCCT3,MFCCT4, brandonTruth, foxTruth, jonnyTruth);
    
%     combResults = [comFFTNN; comFFTLin; comFFTKnn; comMFCCNN; comMFCCLin; comMFCCKnn];
%     xlswrite('ResultsComb.xls', combResults)    
%     finalResults = [natFFTNN;natFFTLin;natFFTKnn;natMFCCNN;natMFCCLin;natMFCCKnn;strFFTNN;strFFTLin;strFFTKnn;strMFCCNN;strMFCCLin;strMFCCKnn];
 %    finalResults = [natFFTLin;natFFTKnn;natMFCCLin;natMFCCKnn;strFFTLin;strFFTKnn;strMFCCLin;strMFCCKnn];
%    cd('/Users/jonathanwang/Documents/MATLAB/7100')
%     xlswrite('Results.xls', finalResults)

%http://stimmdb.coli.uni-saarland.de/help_en.php4#session
    
    

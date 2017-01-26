% Initialize Results
Results = [];
%Store audiofile names
%[training, testing]  = getFileNames();
%training set
% trainingDisordered = dir('/Users/jonathanwang/Desktop/7100 /Demo Data/Disordered Ahh');
% trainingDisordered = {trainingDisordered.name};
% numTrainFiles = 108; %number of training files
% numTrainFiles = numTrainFiles - 1;
% trainingDisordered = trainingDisordered(length(trainingDisordered)-numTrainFiles:end);
% trainingDisordered = trainingDisordered';
% [FEATDisordered] = featureExtraction(trainingDisordered);
% trainingHealthy = dir('/Users/jonathanwang/Desktop/7100 /Demo Data/Healthy Ahh');
% trainingHealthy = {trainingHealthy.name};
% numTrainFiles = 150; %number of training files
% numTrainFiles = numTrainFiles - 1;
% trainingHealthy = trainingHealthy(length(trainingHealthy)-numTrainFiles:end);
% trainingHealthy = trainingHealthy';
% [FEATHealthy] = featureExtraction(trainingHealthy);
% FEAT = [FEATDisordered; FEATHealthy];

load('/Users/jonathanwang/Desktop/7100 /Demo Data/FEAT.mat')
disorderTruth = [ones([108, 1]); 2*ones([150, 1])];

prompt = '0 for demo, 1 to record: ';
test = input(prompt);

if test == 0
testing = dir('/Users/jonathanwang/Desktop/7100 /Demo Data/Test Ahh');
testing = {testing.name};
numTrainFiles = 1; %number of training files
numTrainFiles = numTrainFiles - 1;
testing = testing(length(testing)-numTrainFiles:end);
testing = testing';
[FEATT] = featureExtraction(testing);
k = 1;
Knn = kNN(FEAT,disorderTruth,FEATT,k);%third input should be MFCCR' for recorded
else if test == 1
%Record Audio

    [ x, fs ] = recordVoice(1, 96000);
    %save(file, x);
    cd('/Users/jonathanwang/Documents/MATLAB/7100/ML/Audio/Recorded')
    voiceFile = 'voiceFile.wav';
    audiowrite(voiceFile, x, fs);
    recording = dir('/Users/jonathanwang/Documents/MATLAB/7100/ML/Audio/Recorded');
    recording = {recording.name};
    numTrainFiles = 1; %number of training files
    numTrainFiles = numTrainFiles - 1;
    recording = recording(length(recording)-numTrainFiles:end);
    recording = recording';
    [FEATR] = featureExtraction(recording);   
    Knn = kNN(FEAT,disorderTruth,FEATR);
    end
end
if Knn == 2
    disp('You have a healthy voice');
else if Knn == 1
        disp('You may have a voice disorder');
    end
end
    
%TRAINING
%     %Feature Extraction
%     cd('/Users/jonathanwang/Documents/MATLAB/7100/ML/Audio/Training')
%     [FEAT] = featureExtraction(training); %training set


    
%TESTING
%     %Feature Extraction
%     cd('/Users/jonathanwang/Documents/MATLAB/7100/ML/Audio/Testing')
%     %load ground truth for training set
%     load('/Users/jonathanwang/Documents/MATLAB/7100/ML/disorderTruth.mat')
%     %load ground truth for test set
%     load('/Users/jonathanwang/Documents/MATLAB/7100/ML/testSetTruth.mat')
    
% Define Test File
   
%disorderTruth = [1 1 1 2 2 2 2 2 3 3 3 3 3 3 3 4 4 4 4 4];
    % Define Testng Set (For Evaluation and optimizing)

    %Test Set
    
    
    
    %Classification
    %Natural FFT
    %natFFTNN = nueralNet(FFTN,trainingTruth,FFTS,FFTT1,FFTT2,FFTT3,FFTT4, brandonTruth, foxTruth, jonnyTruth);
    %Lin = linearClassifier(FEAT,disorderTruth,FEATT);%third input should be MFCCR' for recorded
    
    %validateLin = Lin;
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
    
    

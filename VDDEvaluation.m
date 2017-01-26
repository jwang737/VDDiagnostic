%Evaluation: This script is used for evaluating different features and
%classifiers. First it reads the files, then calculates all features and
%generates a ground truth, finally it evaluates

%First Calculate Features
    %Store File Names and groundTruth
    [fileNames, groundTruth]  = getFileNames();
    
    %Feature Extraction
    [FEAT] = featureExtraction(fileNames);
    %Normalize Features
    for i = 1:size(FEAT,2)
        FEAT(:,i) = FEAT(:,i)/max(abs(FEAT(:,i)));
    end
    
%Cross Validation
    K = 10;
    [perf] = crossValidation(FEAT, groundTruth, K );
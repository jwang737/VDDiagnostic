function [ClassificationPerformance] = crossValidation(FEAT, groundTruth, K )
%UNTITLED2 separates features and evaluates via cross validation
%   Detailed explanation goes here

FEAT = FEAT(mod(size(FEAT,1),K)+1:end,:);
groundTruth = groundTruth(mod(size(groundTruth,1),K)+1:end);

%Shuffle dataset
%randomizing
randFEAT = zeros(size(FEAT));
randTruth = zeros(size(groundTruth));
randomMatrix = floor(1000*rand(size(FEAT,1),1 ));
[~,I] = sort(randomMatrix);
for i = 1:size(FEAT,1)
    randFEAT(i,:) = FEAT(I(i),:);
    randTruth(i) = groundTruth(I(i));
end
%rather than changing all the names
FEAT = randFEAT;
groundTruth = randTruth;

% n = number of folds
n = 10;
% s = size of fold
s = floor(length(FEAT)/n);
%initialize estimation matrix
estMat = zeros(length(FEAT),1);
performance = zeros(1,length(FEAT),1);
featPerf = zeros(size(FEAT,2),1);
% store best features
bestFeats = zeros(size(FEAT,2),1);
bestFeatNames = {};
bestFeatPerc = zeros(size(FEAT,2),1);
for feat = 1:size(FEAT,2)
    %for each feature, define train/test data and populate confusion matrix
    for fold = 1:n
    
        %define data sets
        testData = FEAT((fold-1)*s+1:fold*s,feat); % returns normalized feature matrix [1x50] of test data
        testLabel = groundTruth((fold-1)*s+1:fold*s); % returns ground truth matrix [1x50] of test data (for confusion matrix)
        trainData = [FEAT(1:((fold-1)*s),feat); FEAT(fold*s+1:end,feat)]; % returns normalized feature matrix [1x450] of training data
        trainLabel = [groundTruth(1:((fold-1)*s)); groundTruth(fold*s+1:end)]; % returns ground truth matrix [1x450] of training data
        
        % Call Classifier - estimatedClass returns a 50x1 matrix 
        estimatedClass = myKnn(testData, trainData, trainLabel, K);
        estMat((fold-1)*s+1:fold*s) = estimatedClass; %store estimated genre in a 1x500 matrix to be compared with truth
        
    end
    %compare with truth to evaluate feature
    performance = estMat - groundTruth;
    table = tabulate(performance);
    % store performance of each feature
    for r = 1:size(table,1)
        if table(r,1) == 0 % this means file was classified correctly
            featPerf(feat) = table(r,3); % percentage of correctly classiifed files
        end
    end

end
% featPerf now contains the performance of each feature in a 10x1 matrix. 
% Sort features based on performance for use in ffs
[featPerf, I] = sort(featPerf, 'descend');
% output best feature as a string
featureLegend = {1, 'MFCC1'; 2, 'MFCC2'; 
    3, 'MFCC3'; 4, 'MFCC4'; 5, 'MFCC5'; 6, 'MFCC6'; 7, 'MFCC7'; 8, 'MFCC8'; 
    9, 'MFCC9'; 10, 'MFCC10'; 11, 'MFCC11'; 12, 'MFCC12'; 13, 'MFCC13'; 14, 'MFCC14'; 
    15, 'MFCC15'; 16, 'MFCC16'; 17, 'MFCC17'; 18, 'MFCC18'; 19, 'MFCC19'; 20, 'MFCC20'; 
    21, 'Jitter'; 22, 'Shimmer'};
%save best single feature name and performance
bestFeatNames(1) = featureLegend(I(1),2);
bestFeatPerc(1) = featPerf(1);
%store best feature 
newBestFeat = cell2mat(featureLegend(I(1),1));
% now take best feature and evaluate in XD 
flag = 1;
sequence = 1;
while flag == 1
   bestFeats(sequence) = newBestFeat;
   sequence = sequence + 1;
for feat = 1:size(FEAT,2)
    %for each feature, define train/test data and populate confusion matrix
    for fold = 1:10
    
        %define data sets (XD)
        testData = FEAT((fold-1)*s+1:fold*s,feat);% returns normalized feature matrix [1x50] of test data
        testData = [FEAT((fold-1)*s+1:fold*s,newBestFeat), testData]; % returns normalized feature matrix [2x50] of test data with new best feat
        testLabel = groundTruth((fold-1)*s+1:fold*s); % returns ground truth matrix [1x50] of test data (for confusion matrix)
        trainData = [FEAT(1:((fold-1)*s),feat); FEAT(fold*s+1:end,feat)]; % returns normalized feature matrix [1x450] of training data
        trainData = [[FEAT(1:((fold-1)*s),newBestFeat); FEAT(fold*s+1:end,newBestFeat)], trainData]; % returns normalized feature matrix [2x450] of training data
        trainLabel = [groundTruth(1:((fold-1)*s)); groundTruth(fold*s+1:end)]; % returns ground truth matrix [1x450] of training data
        
        % Call Classifier - estimatedClass returns a 50x1 matrix 
        estimatedClass = myKnn(testData, trainData, trainLabel, K);
        estMat((fold-1)*s+1:fold*s) = estimatedClass; %store estimated genre in a 1x500 matrix to be compared with truth
        
    end
    %compare with truth to evaluate feature
    performance = estMat - groundTruth;
    table = tabulate(performance);
    % store performance of each feature
    for r = 1:size(table,1)
        if table(r,1) == 0 % this means file was classified correctly
            featPerf(feat) = table(r,3); % percentage of correctly classiifed files
        end
    end

end

% Sort features based on performance for use in ffs
[featPerf, I] = sort(featPerf, 'descend');
% Store best feature names and performance
bestFeatNames(sequence) = featureLegend(I(1),2);
bestFeatPerc(sequence) = featPerf(1);
%termination condition - if the best feature is one that is already being
%used
newBestFeat = cell2mat(featureLegend(I(1),1));
for i = 1:sequence-1
    if newBestFeat == bestFeats(i)
        flag = 0; % terminate
        bestFeats = bestFeats(1:sequence-1);
        bestFeatNames = bestFeatNames(1:sequence-1);
        bestFeatPerc = bestFeatPerc(1:sequence-1);
    end
end
%store best feature and print best feats
bestFeatNames = bestFeatNames' % unsuppress to see all features used
end
%Results = {bestFeatNames, bestFeatPerc};

%*************** Print things you wanna see**************

% Single Feature Ranking Result
singleFeatureRankingResult= bestFeatNames(1)

% Generate Forward Selection Plot
plot(1:sequence-1,bestFeatPerc)
    % Create xlabel
    xlabel({'Number of Features'});
    % Create ylabel
    ylabel({'Performance (%)'});
    % Create title
    title({'Forward Selection Plot'});
    
% Classification Results + Confusion Matrix
ClassificationPerformance = bestFeatPerc(length(bestFeatPerc)) 
confusionMatrix = confusionmat(groundTruth, estMat)


end


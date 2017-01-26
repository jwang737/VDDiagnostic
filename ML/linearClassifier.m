function [ classes ] = linearClassifier( featArrayTrain , groundTruth, recorded)
%linearClassifier
%   A linear classifier utilizing Matlab's fitcdiscr function. The feature
%   vector is formated with observations as fows and variables(features) as
%   columns.Properties of the classifier can be accesed with dot notation
%   (linClass.ClassNames). Calls the performance evaluation function for
%   all 6 test cases.

%Initialize performance vector
%performance = [0 0 0 0 0 0];

%Build and train the classifier
linClass = fitcdiscr(featArrayTrain,groundTruth);

%Classify using predict
classes = predict(linClass,recorded);
% classesHunt = predict(linClass,testJonnyFoxPeck);
% classesFoxBW = predict(linClass,testFoxNatBW);
% classesJW = predict(linClass,testJW);
% classesTrain = predict(linClass,featArrayTrain);
% classesOtherTrain = predict(linClass,otherTraining);
% 
% %Calculate % of correctly detected keys
% performance(1) = overallPercent( classesBW, brandonTruth );
% performance(2) = overallPercent( classesHunt, foxTruth );
% performance(3) = overallPercent( classesFoxBW, foxTruth );
% performance(4) = overallPercent( classesJW, jonnyTruth );
% performance(5) = overallPercent( classesTrain, groundTruth );
% performance(6) = overallPercent( classesOtherTrain, groundTruth );
end


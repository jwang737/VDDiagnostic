function [ classes ] = kNN( featArrayTrain , groundTruth, recorded, k)
%kNN
%   Classifies the data based off the k-nearest neighbors. Utilizes
%   Matlab's fitcknn function, which takes a feature vector in the same
%   format as the linear classifier (observations are rows, features are
%   columns). Calls a performance evaluation function.

%Initialize performance vector
%performance = [0];

%Normalizing feature and testing vectors
% maxN = max(featArrayTrain,[],2);
% 
% for i = 1:size(featArrayTrain)
%     for j = 1:size(featArrayTrain,2)
%         featArrayTrain(i,j) = featArrayTrain(i,j)/maxN(i);
%     end
% end

%Set number of neighbors
%k = 1;

%Build classifier
knnClass = myKnn(recorded, featArrayTrain,groundTruth,k);

%Classify test file using predict
%classes = predict(knnClass,recorded);
classes = knnClass;
%Calculate performance % for each test file
% performance(1) = overallPercent( classesBW, brandonTruth );

end


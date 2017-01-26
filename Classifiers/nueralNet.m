function [ performance ] = nueralNet( featArrayTrain , groundTruth, otherTraining, testBW, testJonnyFoxPeck, testFoxNatBW, testJW, brandonTruth, foxTruth, jonnyTruth )
%nueralNet 
%   A nueral network utilizing Matlab's newpnn function to create a
%   probabilistic nueral network. The feature vector is formatted with
%   features as rows and columns as observations. The performance
%   evaluation function is also called.

%Initialize performance vector
performance = [0 0 0 0 0 0];

%Traspose feature vectors and ground for correct input into the network
featArrayTrain = featArrayTrain';
groundTruth = groundTruth';
otherTraining = otherTraining';
testBW = testBW';
testJonnyFoxPeck = testJonnyFoxPeck';
testFoxNatBW = testFoxNatBW';
testJW = testJW';

%Converting indices of ground truth to vector (target vector)
targetTruth = ind2vec(groundTruth);

%Create network
network = newpnn(featArrayTrain,targetTruth);

%Simulate network
classesBW = sim(network,testBW);
classesHunt = sim(network,testJonnyFoxPeck);
classesFoxBW = sim(network,testFoxNatBW);
classesJW = sim(network,testJW);
classesTrain = sim(network,featArrayTrain);
classesOtherTrain = sim(network,otherTraining);

%Get classification vectors in readable form
classesBW = vec2ind(classesBW);
classesHunt = vec2ind(classesHunt);
classesFoxBW = vec2ind(classesFoxBW);
classesJW = vec2ind(classesJW);
classesTrain = vec2ind(classesTrain);
classesOtherTrain = vec2ind(classesOtherTrain);

%Calculate performance
performance(1) = overallPercent( classesBW, brandonTruth );
performance(2) = overallPercent( classesHunt, foxTruth );
performance(3) = overallPercent( classesFoxBW, foxTruth );
performance(4) = overallPercent( classesJW, jonnyTruth );
performance(5) = overallPercent( classesTrain, groundTruth );
performance(6) = overallPercent( classesOtherTrain, groundTruth );


end


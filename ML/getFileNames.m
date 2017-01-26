function [ training, testing ] = getFileNames()
%readFiles
%   This function places all filenames in the training and testing
%   directories into a matrix for use with aduioread later on. The function
%   returns file name arrays for all datasets 

%training set
training = dir('/Users/jonathanwang/Documents/MATLAB/7100/ML/Audio/Training');
training = {training.name};
numTrainFiles = 21; %number of training files
numTrainFiles = numTrainFiles - 2;
training = training(length(training)-numTrainFiles:end);
training = training';

%Testing set - this will eventually be used for evaluation once files come
testing = dir('/Users/jonathanwang/Documents/MATLAB/7100/ML/Audio/Testing');
testing = {testing.name};
numTestFiles = 20;
numTestFiles = numTestFiles - 1;
testing = testing(length(testing)-numTestFiles:end);
testing = testing';
end


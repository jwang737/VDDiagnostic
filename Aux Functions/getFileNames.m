function [ training, groundTruth ] = getFileNames()
%readFiles
%   This function places all filenames in the training and testing
%   directories into a matrix for use with aduioread later on. The function
%   returns file name arrays for all datasets 
training = [];
groundTruth = [];
%training set
    %healthy
    healthy = dir('/Users/jonathanwang/Desktop/7100 /VDDiagnostic/Audio/Healthy');
    healthyName = {};
    fileIndex = 1;
    for i = 1:length(healthy)
        if healthy(i).isdir == 0
            healthyName(fileIndex) = {healthy(i).name};
            groundTruth(fileIndex) = 1;
            fileIndex = fileIndex+1;
        end
    end
    healthyName = healthyName';
    training = [training;healthyName];
    
    %Polyp
    polyp = dir('/Users/jonathanwang/Desktop/7100 /VDDiagnostic/Audio/Polyp');
    polypName = {};
    fileIndex = 1;
    for i = 1:length(polyp)
        if polyp(i).isdir == 0
            polypName(fileIndex) = {polyp(i).name};
            groundTruth(fileIndex+length(training)) = 2;
            fileIndex = fileIndex+1;
        end
    end
    polypName = polypName';
    training = [training;polypName];
    
    %Noldule
    nodule = dir('/Users/jonathanwang/Desktop/7100 /VDDiagnostic/Audio/Nodule');
    noduleName = {};
    fileIndex = 1;
    for i = 1:length(nodule)
        if nodule(i).isdir == 0
            noduleName(fileIndex) = {nodule(i).name};
            groundTruth(fileIndex+length(training)) = 3;
            fileIndex = fileIndex+1;
        end
    end
    noduleName = noduleName';
    training = [training;noduleName];
    
    %Neoplasm
    neoplasm = dir('/Users/jonathanwang/Desktop/7100 /VDDiagnostic/Audio/Neoplasm');
    neoplasmName = {};
    fileIndex = 1;
    for i = 1:length(neoplasm)
        if neoplasm(i).isdir == 0
            neoplasmName(fileIndex) = {neoplasm(i).name};
            groundTruth(fileIndex+length(training)) = 4;
            fileIndex = fileIndex+1;
        end
    end
    neoplasmName = neoplasmName';
    training = [training;neoplasmName];

    groundTruth = groundTruth';
end


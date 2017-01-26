training = [];
groundTruth = [];
%training set
%Neoplasm
    neoplasm = dir('/Users/jonathanwang/Desktop/7100 /VDDiagnostic/Audio/Neoplasm');
    neoplasmName = {};
    fileIndex = 1;
    for i = 1:length(neoplasm)
        if neoplasm(i).isdir == 0
            neoplasmName(fileIndex) = {neoplasm(i).name};
            groundTruth(fileIndex+length(training)) = 2;
            fileIndex = fileIndex+1;
        end
    end
    neoplasmName = neoplasmName';
    training = [training;neoplasmName];
    
%randomizing
randFEAT = zeros(size(FEAT));
randTruth = zeros(size(groundTruth));
randomMatrix = floor(1000*rand(size(FEAT,1),1 ));
[sortedMatrix,I] = sort(randomMatrix);
for i = 1:size(FEAT,1)
    randFEAT(i,:) = FEAT(I(i),:);
    randTruth(i) = groundTruth(I(i));
end
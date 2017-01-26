function [estimatedClass] = myKnn(testData, trainData, trainLabel, K)

%Initialization
[totalNeighbors,~] = size(trainData);
eucDist = zeros(totalNeighbors , 1);
estimatedClass = zeros(size(testData,1),1);

%Move through each file in the the test data
for file = 1 : size(testData,1)
    
    %Calculate the Euclidean distance
    for i = 1 : totalNeighbors
        eucDist(i) = sqrt(sum((trainData(i,:) - testData(file,:)).^2));
    end

    %Sort the distances from least to greatest, with indices
    [eucDist, I] = sort(eucDist);

    %Take the the first K indices
    nearest = I(1:K);

    %Put generes of K closest neighbors in voting vector
    vote = zeros(1,K);

    for i = 1 : K
        vote(i) = trainLabel(nearest(i));
    end

    %Determine Genre
    %this takes into account if there is a tie for the number of nearest
    %neighbors and chooses the nearer of the two averages.
      [~,~,C] = mode(vote); 
      C = cell2mat(C);
      numModes = length(C);
    if numModes > 1
        dist = zeros(numModes, 1);
        for m = 1:numModes
            for i = 1:K
                if vote(i) == C(m)
                    dist(m) = dist(m)+eucDist(i);
                end
            end
        end
        [~,I] = min(dist);
        estimatedClass(file) = C(I);
    else
    estimatedClass(file) = mode(vote);
    end
end

end

%%RESULTS for considering Ties
%K = 1 - Same (cant have a tie if there's only 1 nearest neighbor)
%K = 3 - 50% aaccuracy using 'Spectral Crest Std' & 'Spectral Centroid Std'
%K = 7 - 52.6% accuracy using  'Spectral Crest Std' & 'Zero Crossing Std'


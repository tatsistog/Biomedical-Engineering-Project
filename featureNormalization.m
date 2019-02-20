function Data = featureNormalization(Data)

[m,n] = size(Data);

for j = 1:1:n
    features = Data(:,j);
    meanvalue = mean(features);
    mymax = max(features);
    mymin = min(features);
    for i = 1:1:m
        features(i) = (features(i) - meanvalue)/(mymax - mymin);
    end
    Data(:,j) = features;
end

end
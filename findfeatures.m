function [Data,group] = findfeatures(spikesToTest,matchArray, spikeClass, SpikesEst)
%% In this function I find features of my data
spikeData = [];
features = 10;
Data = zeros(size(matchArray,1),features);
group = zeros(size(matchArray,1),1);

for i = 1:1:size(matchArray,1)
    currentspike = spikesToTest(matchArray(i,3),:);
    completespike = SpikesEst(matchArray(i,3),:);
    spikeData = [spikeData; currentspike];
    group(i) = spikeClass(matchArray(i,4));
    [x, y] = ampandwidth(currentspike);
    z = diff(completespike);
    
    Data(i,6) = x;
    Data(i,7) = y;
    Data(i,8) = min(completespike);
    Data(i,9) = findzerosBolzano(completespike(28:end));
    Data(i,10) = max(z(28:end));
    
end
  
  coeff = pca(spikeData);
  coeff = coeff(:,1:5);
  Data(:,1:5) = ((coeff') * (spikeData'))';

end
function [spikeTimesEst, SpikesEst, spikesToTest] = ...
    getSpikes_enhanced(data , T)
% This code is similar as getSpikes function. The only difference is that
% this function returns also the time values and shape of each spike

%% ==================  Counting Spikes ====================================
spikes = 0;
spikeTimesEst = zeros(5000,1);
spikesToTest = zeros(5000);
for i = 2:1:length(data)
    if (data(i) > T && data(i-1)<T )
        spikes = spikes + 1;
        spikeTimesEst(spikes) = i;
    end
end
spikeTimesEst = deleterows(spikeTimesEst);

for i = 1:1:spikes
    counter = 0;
    for j = spikeTimesEst(i):1:spikeTimesEst(i)+32
        if (data(j) > T)
            counter = counter + 1;
            spikesToTest(i,counter) = data(j);
        else
            spikesToTest(i,counter+1) = data(j);
            break;
        end
    end
end

spikesToTest = deleterows(spikesToTest);
spikesToTest = deletecolumns(spikesToTest);

SpikesEst = zeros(spikes,2*32);
for i = 1:1:spikes
    counter = 0;
    for j = spikeTimesEst(i)-31:1:spikeTimesEst(i)+32
        counter = counter + 1;
        SpikesEst(i,counter) = data(j);
    end
end


end
function matchArray = matchspikes(spikeTimes, spikeTimesEst)
%% In this function I match actual spikes with those I estimated as spikes,
%in order to see which of my estimations are correct and which are just 
% noise behaviour

        
i = 1;
j = 1;
matchArray = [];
while(i ~= length(spikeTimesEst) && j ~= length(spikeTimes))
    if(abs(spikeTimesEst(i)- spikeTimes(j))< 60)
        x = spikeTimesEst(i);
        y = spikeTimes(j);
        matchArray = [matchArray; x y i j];
        i = i + 1;
        j = j + 1;
        continue;
    end
    
    if(spikeTimesEst(i) < spikeTimes(j))
        i = i + 1;
        continue;
    end
    
    if(spikeTimesEst(i) > spikeTimes(j))
        j = j + 1;
    end
end


end


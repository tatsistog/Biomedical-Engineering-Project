function SpikesEst_aligned = spikes_alignment(Data,SpikesEst,spikeTimesEst)
%% In this function we align spikes according to their first extrema
[m,n] = size(SpikesEst);
SpikesEst_aligned = zeros(m,n);
for i = 1:1:m
    [spikemax, index_max] = max(SpikesEst(i,:));
    [spikemin, index_min] = min(SpikesEst(i,:));
    index = min(index_max, index_min);
    extrema_time = spikeTimesEst(i) + (index - 32);

    counter = 0;
    for j = extrema_time-31:1:extrema_time+32
        counter = counter + 1;
        SpikesEst_aligned(i,counter) = Data(j);
    end
end

end
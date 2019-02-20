function [spikes] = getSpikes(data , T)
%% ================== Part 1: Initialization ==============================
spikes = 0;

%% ================== Part 2: Counting Spikes =============================
if (data(1)>T)
    spikes = spikes + 1;
end


for i = 2:1:length(data)
    if (data(i) > T && data(i-1)<T)
        spikes = spikes + 1;
    end

end
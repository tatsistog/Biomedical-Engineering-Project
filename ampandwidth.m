function [amplitude,width] = ampandwidth(spike)

currentspike = [];
for i = 1:1:length(spike)
    if(spike(i)~=0)
        currentspike = [currentspike; spike(i)];
    else
        break;
    end
end
amplitude = max(spike);
width = length(currentspike);

end
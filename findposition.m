function position = findposition(spikesArray,n,value)
%% Some sort of binary search
% n = length of spikes Array
L = 1;
R = n;

while(L<=R)
    position = floor((L+R)/2);
    if (spikesArray(position) < value)
        R = position - 1;
    elseif (spikesArray(position) > value)
         L = position+1;
    else
        break;
    end
end
end
function  [Data, group] = plotData(spikesToTest,matchArray,spikeClass)

Data = zeros(size(matchArray,1),2);
group = zeros(size(matchArray,1),1);

for i = 1:1:size(matchArray,1)
    currentspike = spikesToTest(matchArray(i,3),:);
    [x,y] = ampandwidth(currentspike);
    Data(i,1) = x;
    Data(i,2) = y;
    number = spikeClass(matchArray(i,4));
    color = [];
    switch number
        case 1
            group(i) = 1;
            color = [1 0 0];
        case 2
            group(i) = 2;
            color = [0 1 0];
        case 3
            group(i) = 3;
            color = [0 0 1];
    end
    plot(x,y,'-s', 'MarkerSize',2,'MarkerEdgeColor',color,'MarkerFaceColor',color);
    hold on;
end

xlabel('Amplitude');
ylabel('width');
end
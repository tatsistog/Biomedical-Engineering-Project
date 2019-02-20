clear all; close all; clc

%% ==================== Part 1: Loading Data to Structs ===================

Data_Eval = [];
for i=1:4 
    str = strcat('Data_Eval_E_', int2str(i));
    currentData = load(str);
    Data_Eval = [Data_Eval currentData];
end;
 
%% ==================== Part 2: Calculating sigma =========================

sigma = zeros(4,1);
for i=1:1:4
    sigma(i) = (1/0.6745)*median(abs(Data_Eval(i).data));
end


%% ==================== Part 3: Finding spikes ============================

% Calculating Thresholds
T=zeros(4,1);
for i=1:1:4
    T(i) = sigma(i)*empiricalRule(sigma(i));
end

% Spikes from Data_Eval_1
[spikeTimesEst1, SpikesEst1_not_aligned, spikesToTest1] = ...
    getSpikes_enhanced(Data_Eval(1).data,T(1));
% Spikes from Data_Eval_2
[spikeTimesEst2, SpikesEst2_not_aligned, spikesToTest2] = ...
    getSpikes_enhanced(Data_Eval(2).data,T(2));
% Spikes from Data_Eval_3
 [spikeTimesEst3, SpikesEst3_not_aligned, spikesToTest3] = ...
     getSpikes_enhanced(Data_Eval(3).data,T(3));
% Spikes from Data_Eval_4
[spikeTimesEst4, SpikesEst4_not_aligned, spikesToTest4] = ...
    getSpikes_enhanced(Data_Eval(4).data,T(4));
 
% %% ==================== Part 4: Spike sorting =============================

SpikesEst1 = spikes_alignment(Data_Eval(1).data,SpikesEst1_not_aligned,spikeTimesEst1);
SpikesEst2 = spikes_alignment(Data_Eval(2).data,SpikesEst2_not_aligned,spikeTimesEst2);
SpikesEst3 = spikes_alignment(Data_Eval(3).data,SpikesEst3_not_aligned,spikeTimesEst3);
SpikesEst4 = spikes_alignment(Data_Eval(4).data,SpikesEst4_not_aligned,spikeTimesEst4);

%% ================== Part 5: Plotting ====================================
figure;
subplot(2,2,1);
for i = 1:1:size(SpikesEst1,1)
    plot(1:size(SpikesEst1,2),SpikesEst1(i,:));
    hold on;
end
y = ylim;
line([32,32],[y(1) y(2)],'Color','r');
title('Spikes from Data Eval 1');

subplot(2,2,2);
for i = 1:1:size(SpikesEst2,1)
    plot(1:size(SpikesEst2,2),SpikesEst2(i,:));
    hold on;
end
y = ylim;
line([32,32],[y(1) y(2)],'Color','r');
title('Spikes from Data Eval 2');

subplot(2,2,3);
for i = 1:1:size(SpikesEst3,1)
    plot(1:size(SpikesEst3,2),SpikesEst3(i,:));
    hold on;
end
y = ylim;
line([32,32],[y(1) y(2)],'Color','r');
title('Spikes from Data Eval 3');

subplot(2,2,4);
for i = 1:1:size(SpikesEst4,1)
    plot(1:size(SpikesEst4,2),SpikesEst4(i,:));
    hold on;
end
y = ylim;
line([32,32],[y(1) y(2)],'Color','r');
title('Spikes from Data Eval 4');


%% =============== Part 5: Matching spikes ================================
% matchArrays conist of four columns. The first column corresponds to time  
% values we estimated. The second columns corresponds to the actual time
% values, given from Data_Eval.spikeTimes. In the third and fourth column 
% we store the indexes from the estimated and the actual times

matchArray1 = matchspikes(Data_Eval(1).spikeTimes, spikeTimesEst1);
matchArray2 = matchspikes(Data_Eval(2).spikeTimes, spikeTimesEst2);
matchArray3 = matchspikes(Data_Eval(3).spikeTimes, spikeTimesEst3);
matchArray4 = matchspikes(Data_Eval(4).spikeTimes, spikeTimesEst4);

%% Plotting actual spikes and estimations
figure;
subplot(2,2,1);
plot(1:size(matchArray1,1),matchArray1(:,2),1:size(matchArray1,1),matchArray1(:,1));
xlabel('Spike Number');
ylabel('Time');
title('Estimations for data 1');
legend('Actual times', 'Estimated Times');

subplot(2,2,2);
plot(1:size(matchArray2,1),matchArray2(:,2),1:size(matchArray2,1),matchArray2(:,1));
xlabel('Spike Number');
ylabel('Time');
title('Estimations for data 2');
legend('Actual times', 'Estimated Times');

subplot(2,2,3);
plot(1:size(matchArray3,1),matchArray3(:,2),1:size(matchArray3,1),matchArray3(:,1));
xlabel('Spike Number');
ylabel('Time');
title('Estimations for data 3');
legend('Actual times', 'Estimated Times');

subplot(2,2,4);
plot(1:size(matchArray4,1),matchArray4(:,2),...
     1:size(matchArray4,1),matchArray4(:,1));
xlabel('Spike Number');
ylabel('Time');
title('Estimations for data 4');
legend('Actual times', 'Estimated Times');

%% ============== Part 6: Spike sorting - Selecting features ==============
% The two features we selected are the maximum value and the width of the
% spike

figure; hold on;
subplot(2,2,1);
[Data1 , group1] = plotData(spikesToTest1,matchArray1,Data_Eval(1).spikeClass);
title('Spikes from data 1');

subplot(2,2,2);
[Data2 , group2] = plotData(spikesToTest2,matchArray2,Data_Eval(2).spikeClass);
title('Spikes from data 2');

subplot(2,2,3);
[Data3 , group3] = plotData(spikesToTest3,matchArray3,Data_Eval(3).spikeClass);
title('Spikes from data 3');

subplot(2,2,4);
[Data4 , group4] = plotData(spikesToTest4,matchArray4,Data_Eval(4).spikeClass);
title('Spikes from data 4');

%% Calculating accuracy of my classification for only two features
acc1_two_features = MyClassify(Data1,group1);
acc2_two_features = MyClassify(Data2,group2);
acc3_two_features = MyClassify(Data3,group3);
acc4_two_features = MyClassify(Data4,group4);


%% find features

[Data1,group1] = findfeatures(spikesToTest1,matchArray1, Data_Eval(1).spikeClass, SpikesEst1_not_aligned);
[Data2,group2] = findfeatures(spikesToTest2,matchArray2, Data_Eval(2).spikeClass, SpikesEst2_not_aligned);
[Data3,group3] = findfeatures(spikesToTest3,matchArray3, Data_Eval(3).spikeClass, SpikesEst3_not_aligned);
[Data4,group4] = findfeatures(spikesToTest4,matchArray4, Data_Eval(4).spikeClass, SpikesEst4_not_aligned);


%% Normalization
Data1 = featureNormalization(Data1);
Data2 = featureNormalization(Data2);
Data3 = featureNormalization(Data3);
Data4 = featureNormalization(Data4);

%% Calculating accuracy of my classification
acc1 = MyClassify(Data1,group1);
acc2 = MyClassify(Data2,group2);
acc3 = MyClassify(Data3,group3);
acc4 = MyClassify(Data4,group4);


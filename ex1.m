%% Initialization
clear all; close all; clc

%% ==================== Part 1: Loading Data to Structs ===================

Data = [];
for i=1:8 
    str = strcat('Data_Test_', int2str(i));
    currentData = load(str);
    Data = [Data currentData];
end;

%% ==================== Part 2: Plotting Data =============================

figure;
datanumber = 1:1:10000;

for i=1:1:8
    str = strcat('Plot ', int2str(i));
    subplot(4,2,i);
    plot(datanumber , Data(i).data(:,1:10000));
    title(str);
end

%% ==================== Part 3a: Counting Peaks ===========================
% For different values of threshold, due to the equation T = k*sigma we
% count the peaks
sigma = zeros(8,1);
for i=1:1:8
    sigma(i) = (1/0.6745)*median(abs(Data(i).data));
end

k = 2:0.001:4;
spikes = zeros(8,length(k)); % row i corresponds to Data_Test_i
                             % column j corresponds to value k(j)
for i=1:1:8
   for j = 1:1:length(k)
       T = k(j)*sigma(i);
       spikes(i,j) = getSpikes(Data(i).data , T);
   end
end

%% ================== Part 3b : Figure spikes vs k   ======================

for i = 1:1:8
    figure;
    str = strcat('Spikes vs k,data ', int2str(i));
    plot (k, spikes(i,:));
    hold on
    y = Data(i).spikeNum;
    plot (k, ones(size(k))*y);
    hold off
    title(str);
    
end

%% ================== Part 4: Find suitable k values ======================
% For different values of threshold, due to the equation T = k*sigma we
% count the peaks

kval = zeros(8,1);
spikesaprox = zeros(1,8);
for i=1:1:8
    position = findposition(spikes(i,:),length(spikes(i,:)),Data(i).spikeNum);
    kval(i) = k(position);
    spikesaprox(i) = spikes(i,position);
end

figure; hold on;
scatter(sigma,kval);
xlabel('sigma value');
ylabel('k value');
title('k with respect to sigma');


%% ================== Part 5: Regression ==================================
%modelfun = @(b,x)(b(1)+b(2)*exp(-b(3)*(x.*x)));
modelfun = @(b,x)(b(1)+ b(2)*x + b(3)*(x.^2) +...
    b(4)*(x.^3) + b(5)*(x.^4) + b(6)*(x.^5));


beta0 = [1,1,1,1,1,1] ;
beta = nlinfit(sigma,kval,modelfun,beta0);

x = 0.05:0.01:0.42;
y = modelfun(beta,x);
plot(x,y);

% So k = 2.4206 + 1.3221 * exp( -23.7159 * sigma^2 );
% secondrule: k = 
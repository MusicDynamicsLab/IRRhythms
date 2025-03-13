%% KL Divergence and JSD Divergence Calculations
function [JSDs, FinalJSD, CI1, CI2, CI3, CI4, StatsTest, pValues]=JSDCalculation(FinalDensityEstimate)%(UniformPointsSheet, Iteration0)

%% If you want to load in data seperately from the CalculateAndPlotDataFinal script
%load('C:\\Users\\hayes\\MDL Dropbox\\Hayes Brenner\\JacobyRhythms\\Code\\HayesPlots&Stats\\UniformDistributions.mat','UniformPointsSheet', 'FA', 'Iteration0');
%% Otherwise...
load('UniformDistributionsRevised.mat','UniformPointsSheet', 'FA', 'Iteration0');

%% Reorgainzae data
for i=1:(length(FinalDensityEstimate))
    s=size(FinalDensityEstimate{i});
    S=s(1)*s(2);
    FinalDensityEstimate{i}=reshape(FinalDensityEstimate{i},S,1);
    for ii=1:length(FinalDensityEstimate{i})
        if isnan(FinalDensityEstimate{i}(ii,:))==true
            FinalDensityEstimate{i}(ii,:)=0;
        end
    end
    FinalDensityEstimate{i}=FinalDensityEstimate{i}/sum(FinalDensityEstimate{i});

end

%% Create Uniform 
UniformDistributionSize=0;
for i=1:length(UniformPointsSheet{1})
    if UniformPointsSheet{1}(i,:)>0
        UniformDistributionSize=UniformDistributionSize+1;
    end
end
for i=1:length(UniformPointsSheet{1})
    if UniformPointsSheet{1}(i,:)>0
        UniformDistribution(i,:)=(1/UniformDistributionSize);
    else
        UniformDistribution(i,:)=0;
    end
end

%% Calculate JSD's
for i=1:length(UniformPointsSheet)
    JSDs(i,:)=JSD2(UniformDistribution,UniformPointsSheet{i});
end
FinalJSD{1}=JSD2(UniformDistribution,FinalDensityEstimate{1});
FinalJSD{2}=JSD2(UniformDistribution,FinalDensityEstimate{2});
FinalJSD{3}=JSD2(UniformDistribution,FinalDensityEstimate{3});
FinalJSD{4}=JSD2(UniformDistribution,FinalDensityEstimate{4});
FinalJSD{5}=JSD2(UniformDistribution,FinalDensityEstimate{5});
AvgJSD= mean(JSDs);
SEM = std(JSDs);
for i=1:5
    [StatsTest(i), pValues(i)]=ztest(FinalJSD{i},AvgJSD,SEM);
end

%% Calculate Stats
ts1 = tinv(0.95,length(JSDs)-1);      % T-Score 
CI1 = [(AvgJSD-ts1*SEM) (AvgJSD+ts1*SEM)];                      % p<.05
ts2 = tinv(0.98,length(JSDs)-1);      % T-Score 
CI2 = [(AvgJSD-ts2*SEM) (AvgJSD+ts2*SEM)];                      % p<.01
ts3 = tinv(0.99,length(JSDs)-1);      % T-Score 
CI3 = [(AvgJSD-ts3*SEM) (AvgJSD+ts3*SEM)];                      % p<.005
ts4 = tinv(0.998,length(JSDs)-1);      % T-Score 
CI4 = [(AvgJSD-ts4*SEM) (AvgJSD+ts4*SEM)];                    % p<.001

%% Check FinalJSD values against CI intervals. If it falls outside of range, then value meets p value criteria. This is 1 tailed. 

end
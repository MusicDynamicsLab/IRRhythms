%% This is the program to run in order to to generate statistical results 
%% and to plot/visualize the data. 

%% Here, load the data you want to calculate and plot:
load('./PublishedResults/Experiment1/results-12-Dec-2024');
% load('./PublishedResults/Experiment2/results-13-Dec-2024');
% load('./PublishedResults/Experiment2a/results-13-Dec-2024');

%% Set up variables and format data
Repetitions=10; %How many times did the rhythm repeat per iteration?
Iterations=5; %How many iterations were there?

ii=1;
for i=1:(Repetitions*Iterations):length(ALLPTS)  %Organizes the data into appropriate 
    Time1All(ii:ii+9,:)=ALLPTS(i:i+9,:); 
    Time2All(ii:ii+9,:)=ALLPTS(i+10:i+19,:); 
    Time3All(ii:ii+9,:)=ALLPTS(i+20:i+29,:);
    Time4All(ii:ii+9,:)=ALLPTS(i+30:i+39,:); 
    Time5All(ii:ii+9,:)=ALLPTS(i+40:i+49,:);
    ii=ii+10;
end
Trials=length(Time1All)/Repetitions;


for i=1:length(Time1All) %Further orgainzation
    Time1All(i,:)= Time1All(i,:) ./ sum(Time1All(i,:));...
    Time2All(i,:)= Time2All(i,:) ./ sum(Time2All(i,:)); Time3All(i,:)= Time3All(i,:) ./ sum(Time3All(i,:));...
    Time4All(i,:)= Time4All(i,:) ./ sum(Time4All(i,:)); Time5All(i,:)= Time5All(i,:) ./ sum(Time5All(i,:));
end
 
%% Calculate results
[FinalDensityEstimate, Intervals, Means, Coordinates] = CalculateResults(Time1All,Time2All,Time3All,Time4All,Time5All,Trials,Repetitions,Iterations);

%% Plot results
PlotResults(FinalDensityEstimate, Intervals, Means, Coordinates, Pts)

%% Find Statistical Values
[JSDs, FinalJSD, CI1, CI2, CI3, CI4, StatsTest, pValues] = JSDCalculation(FinalDensityEstimate);

%% Save Results (NOTE: If you change which data you're analyzing, be sure to change the name of what you're saving
% save('./Stats/Exp1Results.mat','FinalDensityEstimate','FinalJSD', 'CI1', 'CI2', 'CI3','CI4','StatsTest','pValues');
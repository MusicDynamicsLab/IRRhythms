%% This is the code that takes in the input of responses, and outputs 
%% results that can be plotted and statistically derived.
%% Inputs must be 6 matricies, each of which must have a size of X by 3. Each of which represents an iteration
%% Values should be the % of each IOI size
function[FinalDensityEstimate, IterationsArray, MeanDistribution, X]=CalculateResults(Time1All,Time2All,Time3All,Time4All,Time5All,Trials, Repetitions, Iterations)

%% Load Data, Choose Bin Size, Set Up Variables 
binsize=.005; %% THIS VALUE IS IMPORTANT. It determines resolution of final graphs
Reg= 0.01; %In ms
matrixsize=Repetitions;
M=[0 0; 1 0; .5 sqrt(3/4)];
JacobyIntegerRatios=[0.33333333,0.33333333,0.33333333;0.25,0.25,0.5;0.2,0.2,0.6;...
    0.25,0.5,0.25;0.2,0.4,...
    0.4;0.16667,0.33333,0.5;0.2,...
    0.6,0.2;0.16667,0.5,0.33333;...
    0.5,0.25,0.25;0.4,0.2,...
    0.4;0.33333,0.16667,0.5;0.4,...
    0.40,0.2;0.2857,0.2857,0.42840;...
    0.33333,0.5,0.16667;0.2857,0.4284,...
    0.2857;0.25,0.375,0.375;0.6,...
    0.2,0.20;0.50,0.16667,0.33333;...
    0.5,0.33333,0.16667;0.4284,0.2857,...
    0.2857;0.375,0.25,0.375;0.375,...
    0.3750,0.25];


%% Calculate means for density estimate
Time={Time1All Time2All Time3All Time4All Time5All};
Means= {zeros(Trials,3) zeros(Trials,3) zeros(Trials,3) zeros(Trials,3) zeros(Trials,3)};
CovData={zeros(((Trials)*3),3) zeros(((Trials)*3),3) zeros(((Trials)*3),3) zeros(((Trials)*3),3) zeros(((Trials)*3),3)};
iii=0;
ii=1;
for j=1:Iterations
    for i=1:Trials
        Means{j}(i,:)=[mean(Time{j}(ii:ii+Repetitions-1,1),'omitnan') mean(Time{j}(ii:ii+Repetitions-1,2),'omitnan') mean(Time{j}(ii:ii+Repetitions-1,3),'omitnan')];
        ii=ii+Repetitions;
    end
ii=1;
end

%% Covariance Calculation
i=1;
for j=1:Iterations
    for ii=1:Repetitions:length(Time1All)
        CovData{j}(i:i+2,:)=cov(Time{j}(ii:ii+matrixsize-1,:),"omitrows")+((Reg)^2)*eye(3);
        i=i+3;
    end
    i=1;
end


%% Transform Data for Simplex
IterationsArray={Time{1}*M Time{2}*M Time{3}*M Time{4}*M Time{5}*M};
JacobyIntegerRatios=JacobyIntegerRatios*M;
MeanDistribution={(Means{1}*M) (Means{2}*M) (Means{3}*M) (Means{4}*M) (Means{5}*M)};
NewCovData={CovData{1} CovData{2} CovData{3} CovData{4} CovData{5}};
CovDistribution={0 0 0 0 0 0 };

for j=1:Iterations
    ii=1;
        for i=1:3:length(CovData{1})
            CovDistribution{j}(ii:ii+1,1:2)=M'*NewCovData{j}(i:i+2,:)*M;
            ii=ii+2;
        end
end


%% Create points in simplex for density estimate
% x is going to be any arbitrary coordinate in the simplex. Each x would be a 2x1 array. Do it in iterations of .005. 
j=1;
min1=.09;
min2=.15;
TriangleSlope=(.8*sqrt(3/4)-.09)/(.5-.15);
TriangleSlope2=(.8*sqrt(3/4)-.09)/(.5-.85);
for i=.15:binsize:.85
    for ii=min1:binsize:.8*sqrt(3/4)
        X(j,1:2)=[i ii];
        Equation1=TriangleSlope*i-.1684;
        Equation2=TriangleSlope2*i+1.5540;
        if ii>Equation1 || ii>Equation2 
            X(j,:)=NaN;
        end
        j=j+1;
    end
end
X=rmmissing(X);

%% Kernal Density Estimate
EndPoint=size(X);
DensityEstimate={zeros(EndPoint(1),2+Trials) zeros(EndPoint(1),2+Trials) zeros(EndPoint(1),2+Trials) zeros(EndPoint(1),2+Trials) zeros(EndPoint(1),2+Trials) zeros(EndPoint(1),2+Trials)};
for j=1:Iterations
    DensityEstimate{j}(:,1:2)=X;
end


m=1;
for j=1:Iterations
    %% Get rid of NaN values in mean and cov arrays
    for i=1:length(MeanDistribution{j})
       if isnan(MeanDistribution{j}(i,1))
              CovDistribution{j}(i*2-1,1)=NaN;  
              CovDistribution{j}(i*2-1,2)=NaN;
              CovDistribution{j}(i*2,1)=NaN;  
              CovDistribution{j}(i*2,2)=NaN;
       end
    end
    MeanDistribution{j}=rmmissing(MeanDistribution{j});
    CovDistribution{j}=rmmissing(CovDistribution{j});
    Trials=length(MeanDistribution{j});
    
    %% Calculate Density Estimate
    m=1;
    for l=3:1:(Trials+2)
        for k=1:EndPoint(1)
            DensityEstimate{j}(k,l)=exp((-.5*(X(k,:)-MeanDistribution{j}(l-2,:)))*...
            (CovDistribution{j}(m:m+1,:)^(-1))*(X(k,:)-MeanDistribution{j}(l-2,:))')/...
            (2*pi*sqrt(det(CovDistribution{j}(m:m+1,:))));
        end
        m=m+2;
    end
    
    DensityEstimateNext{j}(:,1:2)=X;
    
    for l=1:EndPoint(1)
        DensityEstimateNext{j}(l,3)=sum(DensityEstimate{j}(l,3:1:Trials+2))./Trials;
    end
    
    for i=1:numel(DensityEstimate{j}(:,1))
        FinalDensityEstimate{j}(round((DensityEstimateNext{j}(i,2)-min1)/(binsize)+1),...
        round((DensityEstimateNext{j}(i,1)-min2)/(binsize)+1))=DensityEstimateNext{j}(i,3);
    end
        for i=1:numel(FinalDensityEstimate{j}(:,1))
            for ii=1:numel(FinalDensityEstimate{j}(1,:))
                if FinalDensityEstimate{j}(i,ii)==0
                    FinalDensityEstimate{j}(i,ii)=NaN;
                end
            end
        end
        
end

%% Some leftover code for investigating individual trials...didn't quite work.
% for j=1:22
%     for i=1:numel(DensityEstimate{6}(:,1))
%         DensityEstimateTrial{j}(round((DensityEstimate{6}(i,2)-min1)/(binsize)+1),...
%         round((DensityEstimate{6}(i,1)-min2)/(binsize)+1))=DensityEstimate{6}(i,j+2);
%     end
%         for i=1:numel(DensityEstimateTrial{j}(:,1))
%             for ii=1:numel(DensityEstimateTrial{j}(1,:))
%                 if DensityEstimateTrial{j}(i,ii)==0
%                     DensityEstimateTrial{j}(i,ii)=NaN;
%                 end
%             end
%         end
% end
end

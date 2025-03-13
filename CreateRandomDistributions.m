%% Creates a series of random distrubtions from a uniform distrubtion. 
%% The input for the function is the number of uniform distributions
%% desired. Created with input from Nori Jacoby

function [UniformDensityEstimate Iteration0]=CreateRandomDistributions(Distributions)
load('C:\Users\hayes\Dropbox\rhythmDevel2\Ed New (V3)\Experiment3a\results-18-Jun-2023.mat','Pts')
M=[0 0; 1 0; .5 sqrt(3/4)];
REGULARIZED_FOR_ONE_POINT=40; 
% in msec
JMP=0.005;%low resolution # replace later with higher resoltution
TOT=2000; %total duration of the patern (ms)
TRUNC_TRESH=300; 
%shortest interval (ms)
f=TRUNC_TRESH/TOT; 
% smallest ratio
ymax=sqrt(3)/2; % top y axis of the full triangle.
TRIP={[0,0],[1,0],[1/2,ymax]}; 
%tip points of the triangle
PT=[TRIP{1}(1),TRIP{1}(2);TRIP{2}(1),TRIP{2}(2);TRIP{3}(1),TRIP{3}(2)];% conversion matrix (v3*PT=v2 convert v3 ratio to point on the triangle v2).
f1=0.8*f; % outerbound square
PS=[[f1,f1,1-2*f1;f,1-2*f1,f1;1-2*f1,f1,f1]]; 
% The outbound triangle that is 0.8 larger than the main triangle
%m1=min(PS*PT);m2=max(PS*PT); 
m1=[.15 .09]; m2=[.85 .6928];
% make the grid bound this larger triangle
xgrid=m1(1):JMP:m2(1); 
% a larger grid that contains the main triangle
ygrid=m1(2):JMP:m2(2); 
% xgrid and ygrid are the grid legends
[X,Y] = meshgrid(xgrid,ygrid); 
%X and Y coordinates

for k=1:Distributions   
    FA{k}=zeros(size(X)); % storage the desired kernel
    point_ratios=randomrhythmgenerator2(275)*M; % an array of size N by 2 with ratios.
    for III=1:size(point_ratios,1)
        miu=point_ratios(III,:);
        Sigma=(PT')*(eye(3)*(REGULARIZED_FOR_ONE_POINT.^2)/(TOT.^2))*PT;
        F = mvnpdf( [X(:) , Y(:) ],miu,Sigma); 
        % make a kernel density for this point with mean miu and Sigma covriance (with possibly regularized Sigma)
        F=F/sum(F); % normalize
        F = reshape(F,length(ygrid),length(xgrid)); 
        % reshape to a form of a matrix
        FA{k}=FA{k}+F; % adding
    end
    FU=reshape(min(ITER_mapcoordinates_tri2clicks([X(:),Y(:)],PT),[],2)>=f,size(X));
    % uniform distribution over the interior of the triangle
    FU=FU/sum(FU(:)); 
    % normalized uniform distribution
    FA{k}=FA{k}.*(FU>0);
    FA{k}=FA{k}/sum(FA{k}(:)); 
    % normalization
    % if you want relative density to uniform to this.
    %FA=FA./(FU+eps)

    s=size(FA{k});
    S=s(1)*s(2);
    UniformPointsSheet{k}=reshape(FA{k},S,1);
    for i=1:s(1)
        for ii=1:s(2)
            if FA{k}(i,ii)==0
                FA{k}(i,ii)=NaN;
            end
        end
    end
save('C:\\Users\\hayes\\MDL Dropbox\\Hayes Brenner\\JacobyRhythms\\Code\\HayesPlots&Stats\\UniformDistributionsRevised.mat','UniformPointsSheet', 'FA');
end

Iteration0=zeros(size(X)); % storage the desired kernel
point_ratios=Pts*M; % an array of size N by 2 with ratios.
for III=1:size(point_ratios,1)
    miu=point_ratios(III,:);
    Sigma=(PT')*(eye(3)*(REGULARIZED_FOR_ONE_POINT.^2)/(TOT.^2))*PT;
    F = mvnpdf( [X(:) , Y(:) ],miu,Sigma); 
    % make a kernel density for this point with mean miu and Sigma covriance (with possibly regularized Sigma)
    F=F/sum(F); % normalize
    F = reshape(F,length(ygrid),length(xgrid)); 
    % reshape to a form of a matrix
    Iteration0=Iteration0+F; % adding
end
FU=reshape(min(ITER_mapcoordinates_tri2clicks([X(:),Y(:)],PT),[],2)>=f,size(X));
% uniform distribution over the interior of the triangle
FU=FU/sum(FU(:)); 
% normalized uniform distribution
Iteration0=Iteration0.*(FU>0);
Iteration0=Iteration0/sum(Iteration0(:)); 
% normalization
% if you want relative density to uniform to this.
%FA=FA./(FU+eps)

s=size(Iteration0);
S=s(1)*s(2);
Iteration0=reshape(Iteration0,S,1);

save('C:\\Users\\hayes\\MDL Dropbox\\Hayes Brenner\\JacobyRhythms\\Code\\HayesPlots&Stats\\UniformDistributionsRevised.mat','UniformPointsSheet', 'FA', 'Iteration0');


%%% this is the mapping function ITER_mapcoordinates_tri2clicks
function xp=ITER_mapcoordinates_tri2clicks(y,PT)
    v=y/PT;
    xp=[1-sum(v(:,2:3),2),v(:,2:3)];
end
save('C:\\Users\\hayes\\MDL Dropbox\\Hayes Brenner\\JacobyRhythms\\Code\\HayesPlots&Stats\\UniformDistributionsRevised.mat','UniformPointsSheet', 'FA', 'Iteration0');

end
%% Some bonus code: We used this to gut check our results by seperating the 
%% triangle into smallers ones, counting the results in each one, and 
%% doing a chi squared analysis
clear all
Triangles=30;
side1(:,1)=linspace(.15,.85,(Triangles+1)); side1(:,2)=.09*ones(length(side1),1);
side2(:,1)=linspace(.5,.15,(Triangles+1)); side2(:,2)=linspace((.8*sqrt(3/4)),.09,(Triangles+1));
side3(:,1)=.5:(.35*(1/Triangles)):.85; side3(:,2)=.8*sqrt(3/4):(-.6028*(1/(Triangles))):.09;
SIDE=(.7/Triangles);

k=0;
p=0;
for ii=0:(Triangles-1)
    for i=2:(Triangles+1-ii)
        xsmall(k+1,:)=[(side2(i+ii,1)+SIDE*p) (side2(i+ii,1)+SIDE*(p+1)) (side2(i+ii-1,1)+SIDE*p)];
        ysmall(k+1,:)=[side2(i+ii,2) side3(i+ii,2) side2(i+ii-1,2)];
        k=k+1;
    end
    p=p+1;
end
%Now do this for all the updisde down triangles
p=0;
for ii=0:(Triangles-1)
    for i=2:(Triangles-ii)
        xsmall(k+1,:)=[(side2(i+ii,1)+SIDE*p) (side2(i+ii,1)+SIDE*(p+1)) (side2(i+ii+1,1)+SIDE*p)];
        ysmall(k+1,:)=[side2(i+ii,2) side3(i+ii,2) side2(i+ii+1,2)];
        k=k+1;
    end
    p=p+1;
end
xsmall(:,4)=xsmall(:,1); ysmall(:,4)=ysmall(:,1);

M=[0 0; 1 0; .5 sqrt(3/4)];
T=csvread('C:\\Users\\hayes\\Dropbox\\rhythmDevel2\\JacobyData\\raw_data\\export.US.BO-ST.csv',1,10, [1 10 17523 12]);
for i=1:length(T)
    k=sum(T(i,:));
    T(i,1)=T(i,1)/k; 
    T(i,2)=T(i,2)/k; 
    T(i,3)=T(i,3)/k;
    NoriPoints(i,:)=T(i,:)*M;
end

load('C:\Users\hayes\Dropbox\rhythmDevel2\Ed New (V3)\Experiment3a\results-18-Jun-2023.mat','Pts')
Iteration{1}=Pts*M;
load('C:\\Users\\hayes\\Dropbox\\rhythmDevel2\\Hayes Current\\PointsExperiment1.mat','Time1All', 'Time2All' ,'Time3All', 'Time4All', 'Time5All');
Iteration{2}=Time1All*M;Iteration{3}=Time2All*M;Iteration{4}=Time3All*M;Iteration{5}=Time4All*M;Iteration{6}=Time5All*M;
for i=1:900
    ChiVector= inpolygon(NoriPoints(:,1),NoriPoints(:,2),xsmall(i,:),ysmall(i,:));
    Nori(i,:)=sum(ChiVector);
end
for i=1:6
    for ii=1:900
        ResultsVector=inpolygon(Iteration{i}(:,1),Iteration{i}(:,2),xsmall(ii,:),ysmall(ii,:));
        IterationResult{i}(ii,:)=sum(ResultsVector);
    end
end
[Table,Chi2,pvalue]=crosstab(Nori,IterationResult{5});
%% Nori counts the number of responses in 900 equilateral triangles within the simplex, using the Boston Student data from Jacoby & McDermott 2017
%% IterationResults is an array that has the responses for our own data. This can change depending on our experiment. 
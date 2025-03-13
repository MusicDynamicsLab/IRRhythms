%% Plots results 
%% The one for the triangle plotting I already have

function[]=PlotResults(FinalDensityEstimate, Iterations, Means, X, Pts)

%% Set up Variables
JacobyIntegerRatios=[0.33333333,0.33333333,0.33333333;0.250000000000000,...
    0.25,0.50;0.200,0.2000,0.6000;...
    0.2500,0.50000,0.25000;0.2000,0.400000000000000,...
    0.400;0.166670000,0.333330000000000,0.50000;0.20,...
    0.6000,0.200000;0.166670000000000,0.500000,0.33333;...
    0.50000,0.250000000000000,0.250;0.4000,0.2000,...
    0.40000;0.333330000000000,0.166670,0.5000000;0.400000000000000,...
    0.400000,0.200000000000000;0.2857000,0.285700000000000,0.4284;...
    0.333330000000000,0.500000000000000,0.166670000000000;0.285700000000000,0.428400,...
    0.285700000;0.250,0.375000000000000,0.375000000000000;0.600,...
    0.2000,0.20;0.5,0.166670000000000,0.333330;...
    0.500,0.33333,0.1666700;0.428400000000000,0.28570,...
    0.2857000;0.375,0.25000,0.375;0.37500,...
    0.375000,0.2500];
M=[0 0; 1 0; .5 sqrt(3/4)];
JacobyIntegerRatios=JacobyIntegerRatios*M;
binsize=.005;
xdensity=.15:binsize:.85;
ydensity=.09:binsize:.8*sqrt(3/4);
[XX,YY]=meshgrid(xdensity,ydensity);
str11={'Iteration 5'};

%% Plotting Initial Distribution
Points=Pts*M;
SetUpTriangle(10000)
hold on
plot(Points(:,1),Points(:,2),'k.','MarkerSize', 8) 
plot(JacobyIntegerRatios(:,1),JacobyIntegerRatios(:,2),'r+','MarkerSize',10,'LineWidth',2)
text(.35, .83, 'Initial Values','FontSize',20)
set(gca, 'Visible', 'off')
axis off
title('Initial Distribution','Fontsize',15)


%% Plotting Iterations 1-4
k=size(FinalDensityEstimate);
k=k(2);
for j=1:k
    figure(j)
    zdensityTrial1=flipud(FinalDensityEstimate{j}); %flips the DensityEstimate0s
    imagesc(X(:,1)',X(:,2)',zdensityTrial1,'AlphaData',~isnan(zdensityTrial1)) 
    colormap jet
    colorbar
    axis off
    
    SetUpTriangle(j+99)
    hold on
    plot(Iterations{j}(:,1),Iterations{j}(:,2),'k.','MarkerSize', 8)
    plot(JacobyIntegerRatios(:,1),JacobyIntegerRatios(:,2),'r+','MarkerSize',10,'LineWidth',2)
    text(.35, .83, 'Initial Values','FontSize',20)
    set(gca, 'Visible', 'off')
end

%% Plotting Iteration 5
figure(1000)
axis()
hold on
    zdensitytest=FinalDensityEstimate{5}; 
    imagesc(xdensity,ydensity,zdensitytest,'AlphaData',~isnan(zdensitytest))
    colormap turbo
    colorbar
    c=colorbar;
    c.Label.String = 'Probability Density Relative to a Uniform Distribution';
    caxis([0 60])
    c.TickLabels{11}='>60';
    strJacoby={'111','112','113','121','122','123','131','132','211','212','213','221','223','231','232','233','311','312','321','322','323','332'};
    for i=1:22
        strJacobyX(i)=JacobyIntegerRatios(i,1)-.025;
        strJacobyY(i)=JacobyIntegerRatios(i,2)+.0225;
    end
plot(Means{5}(:,1),Means{5}(:,2),'w.','MarkerSize', 1)
SetUpTriangle(1000)
plot(JacobyIntegerRatios(:,1),JacobyIntegerRatios(:,2),'w+','MarkerSize',10,'LineWidth',2)
text(strJacobyX,strJacobyY,strJacoby,'Color','w','FontSize',7,'LineWidth',2)
set(gca, 'Visible', 'off')  
title('Iteration 5','Fontsize',15)

%% Final Plot
z=1002;
figure(z)
hold on
    zdensitytest=FinalDensityEstimate{5}; 
    imagesc(xdensity,ydensity,zdensitytest,'AlphaData',~isnan(zdensitytest))
    colormap turbo
    colorbar
    c=colorbar;
    c.Position=  [.88   0.1095    0.0381    0.8159];
    c.Label.String = 'Probability Density Relative to a Uniform Distribution';
    caxis([0 60])
    c.TickLabels{7}='>60';
    strJacoby={'111','112','113','121','122','123','131','132','211','212','213','221','223','231','232','233','311','312','321','322','323','332'};
    for i=1:22
        strJacobyX(i)=JacobyIntegerRatios(i,1)-.016;
        strJacobyY(i)=JacobyIntegerRatios(i,2)+.0225;
    end
SetUpTriangle(z)
plot(JacobyIntegerRatios(:,1),JacobyIntegerRatios(:,2),'w+','MarkerSize',10,'LineWidth',2)
text(strJacobyX,strJacobyY,strJacoby,'Color','w','FontSize',7,'LineWidth',2)
% f=figure(z);
% f.Position=[850   544   560   420];
axis off
title('Iteration 5','Fontsize',15)
set(gca, 'Visible', 'off')




end
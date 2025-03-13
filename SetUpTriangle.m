%% This code is for plotting the triangular axes that make up the ternary 
%% graph used for the plotted results. It also includes the tick marks
%% the Integer Ratios used in Jacoby & McDermott 2017

function SetUpTriangle(PlotNumber)

x=[.15 .85 .5 .15];
y=[.09 .09 (.8*sqrt(3/4)) .09];
height=sqrt(3/4);
M=[0 0; 1 0; .5 height];
p1=[.15 .15 .7]*M; p2=[.15 .7 .15]*M; p3=[.7 .15 .15]*M;
xt=[p1(:,1) p2(:,1) p3(:,1) p1(:,1)];
yt=[p1(:,2) p2(:,2) p3(:,2) p1(:,2)];
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
JacobyIntegerRatios=JacobyIntegerRatios*M;

TriangleSlope=(.8*sqrt(3/4))/(.5);
TriangleSlope2=(.8*sqrt(3/4))/(-.5);

Side1x=[.25 .35 .45 .55 .65 .75];
Side1y=[0.09 0.09 0.09 0.09 0.09 0.09];
Side2x=[.55 .6 .65 .7 .75 .8 ];
Side2y=[(height*.7) (height*.6) (height*.5) (height*.4) (height*.3) (height*.2)];
Side3x=[.2 .25 .3 .35 .4 .45];
Side3y=[(height*.2) (height*.3) (height*.4) (height*.5) (height*.6) (height*.7)];
Side4x=[.8 .75 .7 .65 .6 .55];
Side4y=[(height*.1) (height*.2) (height*.3) (height*.4) (height*.5) (height*.6) (height*.7) (height*.8) (height*.9)];

X1=[.25 .35 .45 .55 .65 .75];
Y1=[.09 .09 .09 .09 .09 .09];
X11=[((.07-.4364)/TriangleSlope2) ((.07-.5750)/TriangleSlope2) ((.07-.7135)/TriangleSlope2)...
     ((.07-.8521)/TriangleSlope2) ((.07-.9906)/TriangleSlope2) ((.07-1.1292)/TriangleSlope2)];
Y11=[.07 .07 .07 .07 .07 .07];
X2=[.2 .25 .3 .35 .4 .45]; 
Y2=[(height*.2) (height*.3) (height*.4) (height*.5) (height*.6) (height*.7)];
X22=[.18 .23 .28 .33 .38 .43];
Y22=[(height*.2) (height*.3) (height*.4) (height*.5) (height*.6) (height*.7)];
X3=[.55 .6 .65 .7 .75 .8];
Y3=[(height*.7) (height*.6) (height*.5) (height*.4) (height*.3) (height*.2)];
X33=[((height*.7)+.02+.155)/TriangleSlope ((height*.6)+.02+.31)/TriangleSlope ((height*.5)+.02+.465)/TriangleSlope ...
    ((height*.4)+.02+.62)/TriangleSlope ((height*.3)+.02+.775)/TriangleSlope ((height*.2)+.02+.93)/TriangleSlope ];
Y33=[((height*.7)+.02) ((height*.6)+.02) ((height*.5)+.02) ((height*.4)+.02) ((height*.3)+.02) ((height*.2)+.02)];

XX1=[.35 .45 .55 .6167 .7 .75]; % 3/5 1/2 2/5 1/3 1/4 1/5
YY1=[.09 .09 .09 .09 .09 .09];
XXX1=[((.07-.5750)/TriangleSlope2) ((.07-.7135)/TriangleSlope2) ((.07-.8521)/TriangleSlope2) ((.07-.9444)/TriangleSlope2)...
    ((.07-1.05985)/TriangleSlope2) ((.07-1.1291)/TriangleSlope2)]; % For 1/3 it's 2/3 of the way between 3rd and 4th tick
YYY1=[.07 .07 .07 .07 .07 .07];

XX2=[.2 .225 .2667 .3 .35 .4]; 
YY2=[(height*.2) (height*.25) (height*.33333) (height*.4) (height*.5) (height*.6)];
XXX2=[.18 .205 .2467 .28 .33 .38];
YYY2=[(height*.2) (height*.25) (height*.33333) (height*.4) (height*.5) (height*.6)];

XX3=[.55 .575 .6167 .65 .7 .75];
YY3=[(height*.7) (height*.65) (height*.6-.0289) (height*.5) (height*.4) (height*.3)];
XXX3=[((height*.7)+.02+.155)/TriangleSlope ((height*.65)+.02+.2325)/TriangleSlope (.6167+.0135) ((height*.5)+.02+.465)/TriangleSlope ...
    ((height*.4)+.02+.62)/TriangleSlope ((height*.3)+.02+.775)/TriangleSlope];
YYY3=[((height*.7)+.02) ((height*.65)+.02) ((height*.6-.0289)+.02) ((height*.5)+.02) ((height*.4)+.02) ((height*.3)+.02)];

str1=[.76 .71 .6267 .56 .46 .36];
str2=[.0594615 .0594615 .0594615 .0594615 .0594615 .0594615];
str3={'1/5','1/4','1/3','2/5','1/2','3/5'};
str4=[.56 .585 .6267 .66 .71 .76];
thang=.086;
str5=[.04+thang*7,.04+thang*6.5,.53,.04+thang*5,.04+thang*4,.04+thang*3];
thing=.0489;
str6=[.41-thing*5 .41-thing*4.5  .23 (.41-thing*3) .41-thing*2 .41-thing];
str7=[.608-thang*5 .608-thang*4.5 .29 (.608-thang*3) .608-thang*2 .608-thang];
str8=[.47 .76 0.14];
str9=[.02 .4 .4];
str10={'Interval 1','Interval 2','Interval 3'};

figure(PlotNumber)
plot(x,y,'k','LineWidth',2) 
hold on
axis off


plot([XX1(1) XXX1(1)],[YY1(1) YYY1(1)],'k','LineWidth',3);
plot([XX1(2) XXX1(2)],[YY1(2) YYY1(2)],'k','LineWidth',3);
plot([XX1(3) XXX1(3)],[YY1(3) YYY1(3)],'k','LineWidth',3);
plot([XX1(4) XXX1(4)],[YY1(4) YYY1(4)],'k','LineWidth',3);
plot([XX1(5) XXX1(5)],[YY1(5) YYY1(5)],'k','LineWidth',3);
plot([XX1(6) XXX1(6)],[YY1(6) YYY1(6)],'k','LineWidth',3);

plot([XX2(1) XXX2(1)],[YY2(1) YYY2(1)],'k','LineWidth',3);
plot([XX2(2) XXX2(2)],[YY2(2) YYY2(2)],'k','LineWidth',3);
plot([XX2(3) XXX2(3)],[YY2(3) YYY2(3)],'k','LineWidth',3);
plot([XX2(4) XXX2(4)],[YY2(4) YYY2(4)],'k','LineWidth',3);
plot([XX2(5) XXX2(5)],[YY2(5) YYY2(5)],'k','LineWidth',3);
plot([XX2(6) XXX2(6)],[YY2(6) YYY2(6)],'k','LineWidth',3);

plot([XX3(1) XXX3(1)],[YY3(1) YYY3(1)],'k','LineWidth',3);
plot([XX3(2) XXX3(2)],[YY3(2) YYY3(2)],'k','LineWidth',3);
plot([XX3(3) XXX3(3)],[YY3(3) YYY3(3)],'k','LineWidth',3);
plot([XX3(4) XXX3(4)],[YY3(4) YYY3(4)],'k','LineWidth',3);
plot([XX3(5) XXX3(5)],[YY3(5) YYY3(5)],'k','LineWidth',3);
plot([XX3(6) XXX3(6)],[YY3(6) YYY3(6)],'k','LineWidth',3);


text(str1, str2, str3)
text(str4, str5, str3)
text(str6-.02, str7, str3)
text(str8, str9, str10,'FontSize',10)
plot(JacobyIntegerRatios(:,1),JacobyIntegerRatios(:,2),'r+','MarkerSize',10,'LineWidth',2)
strJacoby={'111','112','113','121','122','123','131','132','211','212','213','221','223','231','232','233','311','312','321','322','323','332'};
    for i=1:22
        strJacobyX(i)=JacobyIntegerRatios(i,1)-.016;
        strJacobyY(i)=JacobyIntegerRatios(i,2)+.0225;
    end
text(strJacobyX,strJacobyY,strJacoby,'Color','b','FontSize',7,'LineWidth',2)  

end
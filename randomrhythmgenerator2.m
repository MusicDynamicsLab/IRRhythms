%% Generates a random rhythm. Useful for testing results.
function [RandomRhythm]=randomrhythmgenerator2(x)
TOT=2000;
CLICKS=3;
TRUNC_TRESH=TOT*150/1000; %inner tirangle borders (in sec)

% generate uniform samples from the unit simplex
for i=1:x
    p=nan(CLICKS+1,1);
    p(2:CLICKS)=rand(CLICKS-1,1);
    p(1)=0;
    p(CLICKS+1)=1;
    ps=sort(p);
    t=diff(ps);
    assert(abs(sum(t)-1)<1e-10)
    %shift the unit simplex according to the distrebution
    RandomRhythm(i,:)=(t*(TOT-CLICKS*TRUNC_TRESH)+TRUNC_TRESH)';
    assert(sum(RandomRhythm(i,:)>0)==CLICKS);
    assert(abs(sum(RandomRhythm(i,:))-TOT)<1);
    RandomRhythm(i,:)=RandomRhythm(i,:)/sum(RandomRhythm(i,:));
end
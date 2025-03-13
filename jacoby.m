function [Notes, iois] = jacoby(intervals, dur, t2, bdur)

if nargin < 3
    t2 = 20; 
end
if nargin < 4
    bdur = sum(intervals);
end

seed  = zeros(length(intervals), 7);
tatum = dur/sum(intervals);

iois    = tatum*intervals; 
ontimes = cumsum([0 iois]);
onbeats = cumsum([0 intervals]);
ratio   = onbeats(end)/ontimes(end);

seed(:,6) = ontimes(1:end-1);
seed(:,7) = iois/2;
seed(:,1) = onbeats(1:end-1);
seed(:,2) = seed(:,7)*ratio;
seed(:,3) =    9;
seed(:,4) =   77;
seed(:,5) =  127;

Notes = seed;
for start = dur:dur:t2-dur
    ext = seed;
    ext(:,6) = ext(:,6) + start;
    ext(:,1) = ext(:,6)*ratio;
    Notes = [Notes; ext]; 
end
    Notes = [Notes; seed(1,:)]; 
    Notes(end,6) = t2;
    Notes(end,1) = t2*ratio;

    


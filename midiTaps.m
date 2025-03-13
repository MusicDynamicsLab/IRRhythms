function [Notes, iois] = midiTaps(ontimes, onvelos, notenum)

if nargin < 2
    onvelos = 1; 
end
if nargin < 3
    notenum = 75;
end

iois = diff([0 ontimes]);
onbeats = ontimes;
ratio   = onbeats(end)/ontimes(end);

Notes(:,6) = ontimes;
Notes(:,7) = .1;
Notes(:,1) = onbeats;
Notes(:,2) = Notes(:,7)*ratio;
Notes(:,3) =    9;
Notes(:,4) =   notenum;
Notes(:,5) =  round(127*onvelos);

    


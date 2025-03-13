function [meanRiois RIOIS] = newRhythm(s, pks, locs, mfPeaks, iteration)
global DISPLAY

if nargin < 5
    iteration = 2;
end

tf = 20;    % end time for matching
[spks, slocs] = findpeaks(real(s.x), 'MinPeakHeight', .2);

spkt = s.t(slocs);  % Simulus peak times
rpkt = s.t( locs);  % Tap peak times

spkti = find(spkt < tf);
rpkti = find(rpkt < tf);

spkt = spkt(spkti); spks = spks(spkti); slocs = slocs(spkti);
rpkt = rpkt(rpkti); rpks =  pks(rpkti); rlocs =  locs(rpkti);

siois = diff([spkt tf]);
Nspks = length(spks);

rpksT = rpks;
rpksM = [];
rpktT = rpkt;
rpktM = [];
for si = 1:Nspks
    ri = find(abs(spkt(si)-rpktT) == min(abs(spkt(si)-rpktT))); % find closet peak to stimlus peak
    if length(ri)>1
        ri = ri(1); % in case more than one match
    end
    if abs(spkt(si)-rpktT(ri)) < siois(si)/2                    % if it's close enoguh
        rpksM = [rpksM rpksT(ri)];                              % add this event to the match list
        rpktM = [rpktM rpktT(ri)];
        idx = setdiff((1:length(rpktT)), ri);                    % remove it from the to-be-matched list
        rpksT = rpksT(idx);
        rpktT = rpktT(idx);
    else                                                        % if there is no good match
        rpksM = [rpksM NaN];                                    % add Nan to the match list 
        rpktM = [rpktM NaN];                                               
    end
end

if DISPLAY
    figure(102)
    prat = max(real(s.x))/max(mfPeaks); % peaks height ratio, just for display
    plot(s.t, real(s.x), 'k', s.t, mfPeaks*prat, 'r', 'LineWidth', 1.5); axis tight;
    hold on;
    plot(s.t(slocs), spks, 'bv', rpktM, rpksM*prat, 'rv');
    hold off
    grid on
    set(gca, 'XLim', [0 tf], 'YLim', [0 1]);
    zoom xon
end

riois = diff([rpktM tf]);
RIOIS = reshape(riois, 3, 10)';

if iteration == 1
%     RIOIS = RIOIS(4:end, :);
    RIOIS(1:3, :) = NaN;
end

meanRiois = nanmean(RIOIS);
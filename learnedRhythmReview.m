clear all; clc;
setParameters;
global DISPLAY

RECALL = 1;
CARRY  = 0;
LEARN  = 0;
NOISE  = 0;
MODEL = 'MODEL2';

DISPLAY = 1;

for rr = [1, 2:3:22] % 1:length(Rhythms)
    
    rhythm = Rhythms{rr};
    matFileName1 = sprintf('./LearnedRhythms2/learnedMatrix4.mat', rhythm);
    matFileName2 = sprintf('./LearnedRhythms2/model-%d-%d-%d.mat', rhythm);
    Notes = jacoby(rhythm, 2, tf_train);
    [fh, rh, phid] = additiveFourier(rhythm);

    fprintf('rhythm %2d: %d %d %d\n', rr, rhythm)
    fprintf('  harmonics %4.2f - %4.2f \n', fh(1), fh(end))
    figure(3); 
    simplex(rhythm, 'ro');

    % load(matFileName1);
    % Fs = M.fs;
    ts = ts_train;

    s   = stimulusMake(1, 'mid', Notes, ts, Fs, 'display', 8, 'inputType', 'active');
    s.x = ampMult*s.x/rms(s.x);
    s.x = s.x - mean(s.x);
    s.x = hilbert(s.x);    
    
        load(matFileName1)
        C0=real(M.n{2}.con{2}.C);
        % figure(2002)
        % imagesc(M.n{2}.f, M.n{2}.f, C0); colorbar;
        z01 = 0.02*randn(1,N1);
        z02 = 0.02*randn(1,N2);

        eval(makeModel);

    M = modelMake(@zdot2j, @cdot2j, s, M.n{1}, M.n{2});
    M = odeRK4fs(M);

%%
     plotResults(s,M);
     % figure(1)
     % set(gca, 'XLim', 10+[41.9 46])
     % figure(5)
     % set(gca, 'XLim', 10+[41.9 46])
 
%     figure(4)
%     imagesc(s.t, M.n{2}.f, abs(M.n{2}.Z));

     pause

end

%% Plotting
function [] = plotResults(s, M, fh)

    % if nargin < 3
    %     [pks fi2] = findpeaks(abs(M.n{2}.Z(:,end)'), 'MinPeakHeight', .6);
    % else
    %     fi2 = freqToIndex(M.n{2},fh);
    % end

    fig = figure(2001);
    meanfield2 = real(mean(M.n{2}.Z(:,:), 1)); 
    [mfPks, mfLocs, mfSupThresh, thMeanfield] = mfPeaks(meanfield2, s, 2, fig);

    fig = figure(2005);
    plot(s.t, real( M.n{2}.Z(:,:)), 'LineWidth', 2);
    zoom xon
end

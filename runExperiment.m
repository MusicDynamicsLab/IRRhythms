 %% runExperiment; run IR model from the paper
clear; clc

global DISPLAY 
DISPLAY = 0;
RECALL  = 1;
CARRY   = 1;
LEARN   = 0;
NOISE   = 0;
MODEL   = 'MODEL1'; % MODEL1, MODEL2, MODEL2a
fprintf('You are running %s\n', MODEL);

setParameters;

genPts;
NR = [];
ALLPTS = [];
PTIT = [];

tic
ordering = randperm(size(Pts,1));
datapoint = 0;
for pti = ordering
    datapoint = datapoint+1;
    rhythm = nRhythms(pti,:);   
    rr = iRhythms(pti);

        fprintf('rhythm %2d: %d %d %d\n', rr, rhythm);
        if strcmp(MODEL, 'MODEL1')
          matFileName = sprintf('./LearnedRhythms1/model-%d-%d-%d.mat', rhythm);
        end
    
        nextRhythm = Pts(pti,:);
        nextRhythm = nextRhythm/sum(nextRhythm)*sum(rhythm); % categorical rhythm
        dist = sqrt(sum((rhythm-nextRhythm).^2))/sum(rhythm);
    
        fprintf(' start  : %5.3f %5.3f %5.3f - dist: %5.3f\n', nextRhythm, dist);
        if DISPLAY
            figure(2003)
            simplex(nextRhythm); hold on;
        end
        NR = [NR; nextRhythm]; firstRhythm = nextRhythm;
        PTIT = [PTIT; [pti, 0]];
    
        for ii = 1:5
    
            [Notes iois] = jacoby(nextRhythm, 2, tf_test);
            [fh, rh, phid] = additiveFourier(rhythm);
    
            if CARRY & ii > 1
                z01 = M.n{1}.z*.75;
                z02 = M.n{2}.z*.75;
            else
                z01 = (1+i)*0.02*randn(1,N1);
                z02 = (1+i)*0.02*randn(1,N2);
            end
            if RECALL
                load(matFileName)
                C0=real(M.n{2}.con{2}.C); % recalls entire model, so do it first
                f = M.n{2}.f;
                clear M
                % if DISPLAY % for debugging
                %     figure(2002)
                %     imagesc(f, f, C0); % set(gca, 'Clim', [-.5 .5]);
                %     colorbar;
                % end
            else
                C0 = 0.00;
            end
    
            s   = stimulusMake(1, 'mid', Notes, ts_test, Fs, 'display', DISPLAY*Fs/10);
            s.x = ampMult*s.x/rms(s.x);
            s.x = s.x - mean(s.x);
            s.x = hilbert(s.x);
    
            eval(makeModel);
            M = odeRK4fs(M);
    
            [pks, locs, mfPeaks] = plotResults(s, M);
            Taps = midiTaps(s.t(locs), pks/max(pks), 75);
            [meanRiois RIOIS] = newRhythm(s, pks, locs, mfPeaks, ii);
            nextRhythm = meanRiois/sum(meanRiois)*sum(rhythm);
            if sum(isnan(nextRhythm)), nextRhythm=firstRhythm; end;
    
    
            dist = sqrt(sum((rhythm-nextRhythm).^2))/sum(rhythm);
            fprintf(' iter %d : %5.3f %5.3f %5.3f - dist: %5.3f\n', ii, nextRhythm, dist);
            if DISPLAY
                figure(2003)
                simplex(nextRhythm); hold on;
            end
    
            ALLPTS = [ALLPTS; RIOIS];
            NR = [NR; nextRhythm];
            PTIT = [PTIT; [pti, ii]];
        end
        hold off;
    
        save(resFileName, 'ALLPTS', 'NR', 'Pts', 'nRhythms', 'PTIT', 'testingWeight', 'M');
        secs = toc;
        ttc = secs/datapoint * size(Pts,1);
        fprintf('Point %03d/%3d, %7.2f mins, TTC: %7.2f hrs\n', datapoint, size(Pts,1), secs/60, (ttc-secs)/60/60);
    % end
end

hold off;

%% Plotting
function [mfPks, mfLocs, mfSupThresh] = plotResults(s, M, fh)
global DISPLAY

    meanfield2 = real(mean(M.n{2}.Z(:,:), 1)); % Considering all oscillators

    if DISPLAY
        fig = figure(2001);
        [mfPks, mfLocs, mfSupThresh, thMeanfield] = mfPeaks(meanfield2, s, 2, fig);
    else
        [mfPks, mfLocs, mfSupThresh, thMeanfield] = mfPeaks(meanfield2, s, 2);
    end
end

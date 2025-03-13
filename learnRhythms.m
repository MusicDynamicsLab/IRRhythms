%% learnRhythms: Learn model from the paper
clear all; clc; 
global DISPLAY

DISPLAY = 0;  % To make it run fast, set DISPLAY = 0
RECALL  = 1;
CARRY   = 0;
LEARN   = 1;
NOISE   = 0;
MODEL   = 'MODEL1'; % MODEL1, MODEL1a, MODEL2, MODEL2a
fprintf('You are running %s\n', MODEL);

setParameters;

for rr = 1:length(Rhythms) 
    
    rhythm = Rhythms{rr}; fprintf('rhythm %2d: %d %d %d\n', rr, rhythm);
    Notes = jacoby(rhythm, 2, tf_train);
    if strcmp(MODEL, 'MODEL2a')
        Notes(:,6) = Notes(:,6) + sd*randn(length(Notes),1);
    end
    figure(3); simplex(rhythm, 'ro');

    matFileName1 = sprintf('%s/model-%d-%d-%d.mat', folder, rhythm);
    
    s   = stimulusMake(1, 'mid', Notes, ts_train, Fs, 'display', DISPLAY*8);
    s.x = ampMult*s.x/rms(s.x);
    s.x = s.x - mean(s.x);
    s.x = hilbert(s.x);

    %% Recall (the learned matrix)
    if RECALL & ~(rr==1) & strcmp(MODEL(1:6), 'MODEL2')
        load(matFileName)
        C0=real(M.n{2}.con{2}.C);
    else
        C0 = 0.00;
    end
    %% Carryover (actually turned off for learning)
    if CARRY & ~(rr==1)
        z01 = M.n{1}.z*.75;
        z02 = M.n{2}.z*.75;
    else
        z01 = 0.02*randn(1,N1);
        z02 = 0.02*randn(1,N2);
    end
    %% Run the nextwork (with learning)
    eval(makeModel);
    M = odeRK4fs(M);

    % [fh, rh, phid] = additiveFourier(rhythm); % What frequencies are in the rhythm? (see paper Fig 3)
    plotResults(s, M);

    save(matFileName1, 'M', 's');
    if strcmp(MODEL(1:6), 'MODEL2')
        save(matFileName, 'M');
    end

end

%% Plotting
function [] = plotResults(s, M, fh)

    fig = figure(2001);
    meanfield2 = real(mean(M.n{2}.Z(:,:), 1)); %Z(fi2,:)
    [mfPks, mfLocs, mfSupThresh, thMeanfield] = mfPeaks(meanfield2, s, 2, fig);
    
    fig = figure(2005);
    plot(s.t, real( M.n{2}.Z(:,:))); %Z(fi2,:)
    zoom xon

end

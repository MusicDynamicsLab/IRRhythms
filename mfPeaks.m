function [mfPeaks, mfLocs, mfSupThresh, thMeanfield] = mfPeaks(meanfield, s, fw, PLOT)

if nargin < 4
    PLOT = [];
end
    tfilt = -fw:1./s.fs:fw;
    b = normpdf(tfilt, 0, 1)./s.fs;


    meanfield         = double(meanfield);
    avMeanfield       =      filter(b, 1,  meanfield);
    sdMeanfield       = sqrt(filter(b, 1, (meanfield-avMeanfield).^2));
    thMeanfield       = avMeanfield+sdMeanfield*1.25;
    mfSupThresh       = max(0,meanfield-thMeanfield);
    mfSupThresh       = mfSupThresh/(max(mfSupThresh));
    [mfPeaks, mfLocs] = findpeaks(real(mfSupThresh), 'MinPeakDistance', .125*s.fs);

    if ~isempty(PLOT)
        figure(PLOT)
        ax1 = subplot(2,1,1);

        plot(s.t, meanfield, ... % s.t, real(s.x), 
             s.t, avMeanfield, s.t, thMeanfield, 'k:', 'LineWidth', 2); axis tight;
        set(gca, 'YLim', [-.45 1]*max(meanfield)*1.1)

        ax2 = subplot(2,1,2);
        plot(s.t, real(s.x), 'k', s.t, mfSupThresh, 'r', 'LineWidth', 2); axis tight;
        set(gca, 'YLim', [-.15 1.1])

        hold on;
        plot(s.t(mfLocs), mfPeaks, 'bv', 'MarkerSize', 18);
        hold off

        linkaxes([ax1 ax2], 'x'); zoom xon
    end
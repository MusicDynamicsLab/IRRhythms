%% Make Input Rhythm
function [fh, rh, phid] = additiveFourier(rhythm, PLOTS)

if nargin < 2
    PLOTS = 0;
end

subdiv = sum(rhythm);
dur = 2;
tf  = 2;
Fs  = 1000;
Notes  = jacoby(rhythm, dur, tf);
s      = stimulusMake(1, 'mid', Notes, [0 tf], Fs, 'display', 8, 'inputType', 'active');
x = s.x;
t = s.t;

%% Compute Fourier Analysis
T = 1/Fs;
L = length(x)-1;
f = Fs*(0:(L/2))/L;
z = fft(x-mean(x), L);
z = z(1:floor(L/2)+1)/L;

r   = abs  (z);
phi = angle(z);

%% Choose Fourier Components (Harmonics)
 % or go to a maximum of 12 Hz
harmnum  = (1:subdiv) ;     % harmonic numbers of components (minimal)
harmonics = harmnum/dur;    % actual harmonic frequency
href = 1;                   % reference frequency for calculating relative phase

fidx = find(ismember(f, harmonics));    % index of harmonic frequencies in Fourier series
% disp(f(fidx));
Nf = length(fidx);                      % number of harmonics
Z1 = [];                                % fourier compnonets fore reconstruction
for idx = fidx
    z1 = r(idx)*exp(1i*(2*pi*f(idx)*t+phi(idx)))/length(rhythm);
    Z1 = [Z1; z1];
end
 %for href=harmnum
 %end

%% Comnpute relative phase
fh = f(fidx);                           % harmonic frequencies
rh = r(fidx);                           % corrsponding amplitudes IS THIS WHAT I NEED TO USE FOR FILTERING?!?!

% FIrst zero crossing of reference harmonic
zc_idx = find(angle(Z1(href,1:end-1))<=0 & angle(Z1(href,2:end)) >=0);
zc_idx = zc_idx(1)+1;
zc_idx=1;
phizc = angle(Z1(:,zc_idx));

phid=zeros(subdiv);
% Reltaive phase: m*phi_j - k*phi_i See Treffner and Turvey
% Create a new matrix, with every new row being a reference phase
%Add 1 to href for every loop
for href=1:subdiv
    phid(href,:)= harmnum.*phizc(href) - harmnum(href).*phizc'; %This will give one row of the connection matrix
end

% disp(harmnum);
% disp(harmnum(href)'.*ones(size(harmnum)));
zd = exp(1i*phid);                  % Wrap relative phases on circle
phid = angle(zd);                   % Recover phases
ConnectionThreshold=.01;            % Variable for determining when to cut off connections
for ii=1:1:subdiv
    for iii=1:1:subdiv
        if abs(phid(ii,iii))<ConnectionThreshold   %Weak Connections removed
            phid(ii,iii)=0;
        end
    end
end
%The product of the two amplitudes is where you apply the threshold
% disp(phid');

if PLOTS
    %% Figure 1
    figure(101)
    subplot(2,1,1)
    plot(t, real(Z1), 'LineWidth', 2);
    yline(0); grid on
    set(gca, 'XLim', [0 tf]);
    ylabel('Amplitude', 'FontSize', 14)
    xlabel('Time (sec)', 'FontSize', 14)
    legend(num2str(harmonics'))

    subplot(2,1,2)
    plot(t, angle(Z1), 'LineWidth', 2)
    yline(0); grid on
    set(gca, 'XLim', [0 tf]);
    ylabel('Phase', 'FontSize', 14)
    xlabel('Time (sec)', 'FontSize', 14)


    %% Figure 2
    figure(102)
    plot(t, x, 'k', t, real(sum(Z1))*L/length(harmonics).^2, 'LineWidth', 2)
    set(gca, 'XLim', [0 tf]); %
    set(gca, 'FontSize', 12)
    ylabel('Pulse Amplitude', 'FontSize', 14)
    xlabel('Time (sec)', 'FontSize', 14)

    %% Figure 3
    figure(103)
    % Amplitude Axis
    ax102a = subplot(2,1,1);
    bar(fh, rh, .3);
    %     set(ax102a, 'FontSize', 12); ax1 = gca;
    ylim = get(ax102a, 'YLim'); ylim = ylim(2);
    set(ax102a, 'XLim', [0 fh(end)+.2], 'YLim', ylim*[-1 1], 'XColor', 'b', 'YColor', 'b')
    ylabel('Amplitude', 'FontSize', 14)
    xlabel('Frequency (Hz)', 'FontSize', 14)


    % Phase Axis
    ax102b = subplot(2,1,2);
    bar(fh, phid, .3, 'b')
    set(ax102b, 'XLim', [0 fh(end)+.2], 'YLim', [-.1, +.1]+[-pi pi], 'FontSize', 12, ...
        'YTick', [-pi:pi/subdiv:pi]'); %, ...
    %         'YTickLabel', {'-\pi', '\pi/2', '0', '\pi/2', '\pi'}, ...
    %         'XTickLabel', {})
    ylabel('Phase', 'FontSize', 14)
    grid on
    hold off

    linkaxes([ax102a ax102b], 'x')
    zoom xon

    figure(27)
    bar3(abs(phid));
    title('Connection Matrix Fourier','FontSize',15)

end

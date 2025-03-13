clear; clc

global DISPLAY 
DISPLAY = 0;
RECALL  = 1;
CARRY   = 0;
LEARN   = 0;
NOISE   = 0;
MODEL   = 'MODEL1a'; % MODEL1a or MODEL1b
fprintf('You are running %s\n', MODEL);

setParameters;
customMap = ones(256,3);
customMap(1:127,2) = linspace(0,.9,127);
customMap(1:127,3) = linspace(0,.9,127);
customMap(130:256,1) = linspace(.9, 0, 127);
customMap(130:256,2) = linspace(.9, 0, 127);

figure(101); clf;
folder = 'LearnedRhythms1a'; % 1a or 1b
    Rhythms = Rhythms1a;      % 1a or 1b

    minColorLimit = -1;                   % determine colorbar limits from data
    maxColorLimit = 1;
for rr = 1:length(Rhythms)

    rhythm = Rhythms{rr};
    fprintf('rhythm %2d: %5.2f %5.2f %5.2f\n', rr, rhythm)
    rtitle = sprintf('%5.2f %5.2f %5.2f\n', rhythm);
    % figure(11)
    % simplex(rhythm, 'ro');
    matFileName = sprintf('./%s/model-%d-%d-%d.mat', folder, rhythm);
    fig=figure(101);
    subplot(1,7,rr)

    load(matFileName)
        Cabs=abs(M.n{2}.con{2}.C);
        Cangle=angle(M.n{2}.con{2}.C);
        Creal=real(M.n{2}.con{2}.C);
        imagesc(M.n{2}.f, M.n{2}.f, Creal)
        grid
        set(gca, 'CLim', [-.61 .61], ...
                 'XLim', [M.n{2}.f(1), 4.125], 'YLim', [M.n{2}.f(1), 4.125], ...
                 'FontSize', 12)
        % set(gca, 'CLim', [-.61 .61], ...
        %          'XLim', [M.n{2}.f(1), 2.625], 'YLim', [M.n{2}.f(1), 2.625], ...
        %          'FontSize', 10)
        title(rtitle)
        colormap(customMap);
   %     pause
    if rr==7
        figure(102)

        set(gca, 'CLim', [-.61 .61])     
        colormap(customMap);
        colorbar('southoutside', 'FontSize', 12)
        xlabel 'Connection Strength'
        

    end
end

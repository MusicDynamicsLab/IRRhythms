clear; clc

global DISPLAY 
DISPLAY = 0;
RECALL  = 1;
CARRY   = 0;
LEARN   = 0;
NOISE   = 0;
MODEL   = '';
fprintf('You are running %s\n', MODEL);

setParameters;
customMap = ones(256,3);
% customMap(1:127,2) = linspace(0,.9,127);
% customMap(1:127,3) = linspace(0,.9,127);
customMap(1:256,1) = linspace(1, 0, 256);
customMap(1:256,2) = linspace(1, 0, 256);

figure(101); clf;
figure(102); clf;
folder2  = 'Experiment2';
folder2a = 'Experiment2a';
resultFile2  = 'results-13-Dec-2024.mat';
resultFile2a = 'results-13-Dec-2024.mat';

minColorLimit = -1;                   % determine colorbar limits from data
maxColorLimit = 1;

figure(101)
matfilename2 = sprintf('./%s/%s', folder2, resultFile2)
load(matfilename2)
Cabs2=abs(M.n{2}.con{2}.C);
imagesc(M.n{2}.f, M.n{2}.f, Cabs2)
max(max(Cabs2))
set(gca, 'CLim', [0 .75], ...
            'XLim', [M.n{2}.f(1), 4.125], 'YLim', [M.n{2}.f(1), 4.125], ...
            'FontSize', 12)
title('Experiment 2')
colormap(flipud(hot));


figure(102)
matfilename2a = sprintf('./%s/%s', folder2a, resultFile2a)
load(matfilename2a)
Cabs2a=abs(M.n{2}.con{2}.C);
imagesc(M.n{2}.f, M.n{2}.f, Cabs2a)
max(max(Cabs2a))
set(gca, 'CLim', [0 .75], ...
            'XLim', [M.n{2}.f(1), 4.125], 'YLim', [M.n{2}.f(1), 4.125], ...
            'FontSize', 12)
title('Experiment 2a')
colormap(flipud(hot));


figure(103)

set(gca, 'CLim', [0 .75])
colormap(flipud(hot));
colorbar('southoutside', 'FontSize', 12)
xlabel 'Connection Strength'


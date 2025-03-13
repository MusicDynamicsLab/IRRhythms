%% Make Two Networks
% Network 1 – Auditory (Perception)
n1 = networkMake(1, 'hopf', alpha1, beta11, beta12, delta11, delta12,  neps1, ...
                    'lin', lf1, hf1, N1, 'tick', [0.5, 1:8], 'display', DISPLAY*Fs/10, ...
                    'znaught', z01, 'save', 1); 

% Network 2: – Motor (Pattern Generation)
n2 = networkMake(2, 'hopf', alpha2, beta21, beta22,  delta21, delta22, neps2, 'noscale',...
                    'lin', lf2, hf2, N1, 'tick', [0.5, 1:8], 'display', DISPLAY*Fs/10, ...
                    'znaught', z02, 'save', 1);

%% Add Connections
% Connect stimulus to auditory network 
n1 = connectAdd(s, n1, .5, 'type', '1freq');    % Connection type 1freq to keep it simple

% Connect auditory to motor network 
wn21 = [ones(1,length(find(n2.f<=4))), linspace(1.0, 0.0, length(find(n2.f>4)))]';
C1 = diag(wn21); 
n2 = connectAdd(n1, n2, C1, 'weight', .25, '1freq');

% Connect motor network to iteself (learning is only active during training)
if LEARN
    n2 = connectAdd(n2, n2, C0, 'weight', learningWeight*wn21, 'type', '2freq', ... 
        'learn', lambdaI, mu1I, mu2I, cepsI, kappaI, ...
        'display', DISPLAY*Fs/10);
else
    n2 = connectAdd(n2, n2, C0, 'weight', testingWeight*wn21, 'type', '2freq'); % testingWeight
end

%% Make Model
% Connect stimulus to auditory network 

if NOISE 
    sn = stimulusMake(2, 'fcn', s.ts, Fs, {'noi'}, 1, .025);
    n2 = connectAdd(sn, n2, 1, 'weight', 1, 'type', '1freq');

    if strcmp(MODEL(1:6), 'MODEL2')
        M = modelMake(@zdot2j, @cdot2j, s, sn, n1, n2);
    else
       M = modelMake(@zdot, @cdot1, s, sn, n1, n2);
    end
else
    if strcmp(MODEL(1:6), 'MODEL2')
        M = modelMake(@zdot2j, @cdot2j, s, n1, n2);
    else
       M = modelMake(@zdot, @cdot1, s, n1, n2);
    end
end


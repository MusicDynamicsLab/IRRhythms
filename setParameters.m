%% setParameters.m

%% Stimulus Parameters
ampMult = 0.15;             % Input amplitude (after normalization by RMS amplitude)         
Fs = 200;                   % Input sample rate
fprintf('Your temporal resolution is %5.3f ms\n', 1000/Fs);

ts_train = [0 104];         % Input simulation time
tf_train = 96;              % Length of training input (note difference)
ts_test = [0 20];           % Input simulation time
tf_test = 20;               % Length of training input (note difference)

%% NETWORK 1 – Auditory (Perception)
lf1 = 0.125; hf1 = 8.125; N1 = length(lf1:lf1:hf1);         % Oscillator frequencies 
alpha1 = -.05; beta11 = 0; beta12 = -.1; neps1 = 1;         % Subcritical Hopf Regime
delta11 =  0; delta12 = 0;                                  % Freq detuning not used

%% NETWORK 2 – Motor (Rhythm Generation)
lf2 = 0.125; hf2 = 8.125; N2 = length(lf2:lf2:hf2);         % Oscillator frequencies 
alpha2 =  -0.36; beta21 = 1.75; beta22 =-1.5; neps2 = 1;    % Subcritical DLC regime
delta21 = 0; delta22 = 0;                                   % Freq detuning not used
% AVFGUI(alpha2, beta21, beta22, neps2)                     % Uncomment to inspect oscillator amplitude vector field

%% HEBBIAN LEARNING and Connection parameters
lambdaI = -0.4; mu1I =  3; mu2I = -4.2; cepsI = 1;          % Supercritical DLC regime
kappaI = 1.5;                                               % Learning rate
% AVFGUI(lambdaI, mu1I, mu2I, cepsI);                       % Uncomment to inspect connection amplitude vector field

%% Function to make the model (networks and connections)

makeModel = 'make1Auditory1Motor'; % Function to make the network (variable to try different architectures)

%% Jacoby & McDermott's Rhyhms
Rhythms = {[1 1 1]; 
           [2 1 1]; [1 2 1]; [1 1 2]; 
           [3 1 1]; [1 3 1]; [1 1 3]; 
           [2 2 1]; [1 2 2]; [2 1 2]; 
           [3 2 1]; [1 3 2]; [2 1 3]; 
           [3 1 2]; [2 3 1]; [1 2 3]; 
           [3 2 2]; [2 3 2]; [2 2 3]; 
           [3 3 2]; [2 3 3]; [3 2 3]};

Rhythms1a = {[1.00000    1.00000    1.00000];
             [0.34030    0.31940	0.34030];
             [0.34720    0.30560	0.34720];
             [0.35417	 0.29170	0.35417];
             [0.36111	 0.27780	0.36111];
             [0.36806	 0.26389	0.36806];
             [0.37500	 0.25000    0.37500];
            };

Rhythms1b = {[0.5000    0.2500    0.2500]; %% This one is extra ... not published .. Try it!
             [0.4833    0.2750    0.2417];
             [0.4667    0.3000    0.2333];
             [0.4500    0.3250    0.2250];
             [0.4333    0.3500    0.2167];
             [0.4167    0.3750    0.2083];
             [0.4000    0.4000    0.2000];
            };

if strcmp(MODEL, 'MODEL1')
    folder = './LearnedRhythms1/';
    resFileName = sprintf('./Experiment1/results-%s.mat', date);
    learningWeight = 0.0;           % Multiplier of connection parameter during learning
    testingWeight  = 2.0;           % Multiplier of connection parameter during testing % Was 1?
    lambdaI = 0; mu1I =  0; mu2I = -1; cepsI = 1;          % Critical regime (used for 'S')

elseif strcmp(MODEL, 'MODEL1a')
    folder = './LearnedRhythms1a/';
    Rhythms = Rhythms1a;
    learningWeight = 0.0;  % Multiplier of connection parameter during learning
    testingWeight  = 2.0;  % Multiplier of connection parameter during testing
    lambdaI = 0; mu1I =  0; mu2I = -1; cepsI = 1;          % Critical regime

elseif strcmp(MODEL, 'MODEL2')
    folder = './LearnedRhythms2/';
    matFileName = sprintf('%s/learnedMatrix.mat', folder);
    resFileName = sprintf('./Experiment2/results-%s.mat', date);
    learningWeight = 1;  % Multiplier of connection parameter during learning
    testingWeight  = 4;  % Multiplier of connection parameter during testing 

else strcmp(MODEL, 'MODEL2a')
    sd = 0.040;
    folder = './LearnedRhythms2a/';
    matFileName = sprintf('%s/learnedMatrix.mat', folder);
    resFileName = sprintf('./Experiment2a/results-%s.mat', date);
    learningWeight = 1;  % Multiplier of connection parameter during learning
    testingWeight  = 4;  % Multiplier of connection parameter during testing

end

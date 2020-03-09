%% Create an RM3 study object
study = WecOptTool.RM3Study();

%% Create Bretschnider spectra from WAFO
%S = bretschneider([],[8,10],0);

% Set uniform random sample [0, 2pi] for 'phasing'
%S.ph = rand(length(S.w),1)* 2 * pi;

%% Alternatively load an example spectra from a file
example_data = load(['example_data' filesep 'spectra.mat']);
S = example_data.S;

%% Add spectra to study
study.addSpectra(S);

%% Add a controller to the study
cc = WecOptTool.control.ComplexConjugate();
study.addControl(cc);

%% Add geometry design variables (parametric)
x0 = [5, 7.5, 1.125, 42];
lb = [4.5, 7, 1.00, 41];
ub = [5.5, 8, 1.25, 43];

parametric = WecOptTool.geom.Parametric(x0, lb, ub);
study.addGeometry(parametric);

%% Add geometry design variables (scalar)
% x0 = 1.;
% lb = 0.5;
% ub = 2;
% 
% scalar = WecOptTool.geom.Scalar(x0, lb, ub);
% study.addGeometry(scalar);

%% Set up some optimisation options for fmincon
options = optimoptions('fmincon',                   ...
                       'MaxFunctionEvaluations', 5, ...
                       'UseParallel', true);

%% Run the study
WecOptTool.run(study, options);

%% Print the results
WecOptTool.result(study);

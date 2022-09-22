function run_random(varargin)
%%                  run_random( optName1, optVal1, ... )

addpath(genpath('functions'))

% choose solution field names, these will be exported in the caller
% workspace
output = struct();
optName  = "options";
EOSname  = "equations";
solName  = "solution";
timeName = "time";

% the range of data options can be found through 
%   help setOptions
dataRange = [1,6];
simRange  = [7,8];

%% Generate Equation Of State

nRods = 2;
opt   = setOptions(varargin);

if isempty(varargin)
    EOSpath = ['EOS_',num2str(nRods),'+default.mat'];
    load(EOSpath, 'n', 'K', 'EOS')
else
    % generate options and save EOS
    [EOS, K, n]     = genEOS(opt,dataRange);
end

%% Simulate random initial condition

% write simulation option in the workspace
writeOptions(opt,simRange)
maxDeg_rad = pi/180*maxDeg;

% generate random initial condition with -degMax < angle (X(2))  < degMax
% and zero velocities, at the origin (X(1) = 0)
X0      = zeros([n,1]);
circ    = 0.3;
X0(2:n/2)  = circ*maxDeg_rad*rand([n/2-1,1]) + (1-circ)*maxDeg_rad;

% simulate 
[t, tmp] = ode113(EOS, [0,tFinal], X0);
Xh = tmp'; clear tmp

%% Plot some result

% write data for postprocessing
writeOptions(opt,dataRange);

% display animation
animateSolution(t, Xh, l, n)

% Control force
u = (K*Xh)/(M+m)/g;
figure
plot(t,u,'LineWidth',1.4)
xlabel('Time [s]','Interpreter','latex')
ylabel('Force [g-units]','Interpreter','latex')
title('\textbf{Force applied by the controller}','Interpreter','latex')

% cart velocity
figure
plot(t,Xh(3,:),'LineWidth',1.4)
xlabel('Time [$s$]','Interpreter','latex')
ylabel('Velocity along x direction [$\frac{m}{s}$]','Interpreter','latex')
title('\textbf{Cart Velocity}','Interpreter','latex')

%% Export variables in the caller workspace

output.(optName)   = opt;
output.(EOSname)   = EOS;
output.(timeName)  = t;
output.(solName)   = Xh;

% load solution fields
varaibles = fieldnames(output);
for ii = 1:length(varaibles)
    assignin('caller', varaibles{ii}, output.(varaibles{ii}))
end
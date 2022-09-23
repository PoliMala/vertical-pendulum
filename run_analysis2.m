function run_analysis2(varargin)

addpath(genpath('functions'))

% choose solution field names, these will be exported in the caller
% workspace
output = struct();
optName   = "options";
EOSname   = "equations";
solInName = "inside";
solXName  = "XeqVal";

%% Generate Equation Of State

nRods = 2;

% get options
opt   = setOptions(varargin);

% write all the options in the workspace
writeOptions(opt)
maxDeg_rad = pi/180*maxDeg;
n = 2*(nRods+1);

% load EOS data
EOSpath = ['EOS_',num2str(nRods),'+default.mat'];
load(EOSpath, 'EOS')

%% Basis of attraction analysis

% Initialize the analysis
Nval = Nth;                            % # values per angle
x = 1e-6;                              % VALUES THATCAN BE TOONED 
th0 = x*maxDeg_rad;                    % 
thVal = 10.^linspace(log10(th0), log10(maxDeg_rad),Nval); 
isIn   = zeros([Nval,1]);              % storage boolean vector
XeqVal = zeros([Nval,1]);              % storage vector for final position
disp(['  Evaluating solutions for ',num2str(Nval*Nval),' initial conditions:'])

% sinlge simulation times
DT = tFinal/Ns;

% number of inner loops without messages
Nnm = Nval/Nm;

% initilize loop
CI = zeros([n,1]);          % set zero velocity as initial condition
i1 = 0;                     % initialize number of iterations performed
exitLoop = @(check,it) and( or(check<tolOut, check>tolIn), it<Ns);

% outer loop for message display:
%       this choice is to avoid an if statement inside the loop
for ii = 1:Nm
    % print number of iterations occurred
    disp(['    more than ',num2str(i1*Nval),' iterations performed ...'])

for jj = 1:Nnm
    % evaluate i1: actual iteration index
    i1 = (ii-1)*Nnm + jj;
    % set theta1 initial value
    CI(2) = thVal(i1);

    for i2 = 1:Nval
        % set theta2 initial value
        CI(3) = thVal(i2)*scale;
        sol = CI';
        
        % run simulations till either convergence, divergence or t>tFinal
        check = 1; it = 0;
        while exitLoop(check, it)
            it = it+1;
            [~,sol,~] = ode45(EOS, [0,DT], sol(end,:));
            check = sum(abs(sol(end,2:end)));
        end

        % register if convergence occurs
        isIn(i1,i2) = sum(abs(sol(end,2:end)))<tolIn;
        % register stable result on X1eq
        XeqVal(i1,i2) = (sum(abs(sol(end,2:end)))<tolIn)*sol(end,1);
    end
end
end
disp('    completed.')


figName = ...
  ['fig/BOA_N',num2str(Nval^2,fix(2*log10(Nval))+1),'_S',num2str(scale*100,3)];
% Display the basis of attraction
figure; contour(thVal,thVal*scale,XeqVal);
xlabel('$\theta_1\,\,[rad]$','interpreter','latex')
ylabel('$\theta_2\,\,[rad]$','interpreter','latex')
title('\textbf{Basisi of attraction for different values of the final position}', ...
      'Interpreter','latex')
axis('equal')

saveas(gcf,figName,'png')

% Display the basis of attraction boundary
figure; contour(thVal,thVal*scale,isIn,...
                                'k','LineWidth',1.2,'levels',1);
xlabel('$\theta_1\,\,[rad]$','interpreter','latex')
ylabel('$\theta_2\,\,[rad]$','interpreter','latex')
title('\textbf{Basisi of attraction boundary}','Interpreter','latex')
axis('equal')

saveas(gcf,[figName,'_boundary'],'png')

%% Export variables in the caller workspace

output.(optName)   = opt;
output.(EOSname)   = EOS;
output.(solInName) = isIn;
output.(solXName)  = XeqVal;

% load solution fields
varaibles = fieldnames(output);
for ii = 1:length(varaibles)
    assignin('caller', varaibles{ii}, output.(varaibles{ii}))
end
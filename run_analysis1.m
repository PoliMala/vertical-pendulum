function run_analysis1(varargin)
%%                  run_analysis( optName1, optVal1, ... )


addpath(genpath('functions'))

% choose solution field names, these will be exported in the caller
% workspace
output = struct();
optName  = "options";
EOSname  = "equations";


%% Generate Equation Of State

nRods = 1;
n = 2*(nRods+1);
opt   = setOptions(varargin);
writeOptions(opt)
maxDeg_rad = pi/180*maxDeg;

% load EOS data
EOSpath = ['EOS_',num2str(nRods),'+default.mat'];
load(EOSpath, 'EOS')

% Initialize the analysis
Nval = Nth;                                     % # values per angle
x = 1-1e-2;
th0 = x*maxDeg_rad;
thVal = 10.^linspace(log10(th0), log10(maxDeg_rad),Nval); 
isIn  = zeros([Nval,1]);                        % storage boolean vector
X0val = zeros([Nval,1]);                        % storage vector for final position
disp(['  Evaluating solutions for ',num2str(Nval),' initial conditions:'])

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
    disp(['    more than ',num2str(i1),' iterations performed ...'])

    for jj = 1:Nnm
        % evaluate i1: actual iteration index
        i1 = (ii-1)*Nnm + jj;
        % set theta1 initial value
        CI(2) = thVal(i1);
        
        % run simulations till either convergence, divergence or t>tFinal
        sol = CI';
        check = 1; it = 0;
        while exitLoop(check,it)
            it = it+1;
            [~,sol] = ode78(EOS, [0,DT], sol(end,:));
            check = sum(abs(sol(end,2:end)));
        end

        % register if convergence occurs
        isIn(i1) = sum(abs(sol(end,2:end)))<tolIn;
        % register stable result on X1eq
        X0val(i1) = (sum(abs(sol(end,2:end)))<tolIn)*sol(end,1);

    
    end
end
disp('    completed.')

% Display the basis of attraction boundary
mask = (isIn==1);
figure
loglog(thVal(mask), X0val(mask), 'b.','MarkerSize',1);
xlabel('$\theta_0\,\,[rad]$','interpreter','latex')
ylabel('$x_{eq}\,\,[m]$','interpreter','latex')
title('\textbf{Basisi of attraction boundary}','Interpreter','latex')
xlim([thVal(1),thVal(end)])

figName = ...
  ['fig/BOA_N',num2str(Nval,2),'_n',num2str(nRods)];
saveas(gcf,[figName,'_boundary'],'png')

%% Export variables in the caller workspace

output.(optName)   = opt;
output.(EOSname)   = EOS;

% load solution fields
varaibles = fieldnames(output);
for ii = 1:length(varaibles)
    assignin('caller', varaibles{ii}, output.(varaibles{ii}))
end
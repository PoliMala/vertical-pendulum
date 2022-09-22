function problemOpt = setOptions(varargin)
%%                           setOptions( ... )
%
% Function generating a struct containing option fields for the problem
% under examination, by default it contains 
%
%   data properties: (range = [1,6])
%       g       ->      gravitational constant
%       M       ->      cart mass
%       m       ->      body mass
%       l       ->      rod length 
%       h       ->      viscous dissipation coefficient
%       domEig  ->      control system dominant eigenvalue absolute value
%
%   simulation properties: (range = [7,8])
%       maxDeg  ->      max initial deviation from vertical direction
%       tFinal  ->      final simulation time
%
%   Basis Of Attraction analysis properties: (range = [10,14])
%       Nth     ->      number of initial deviation values 
%       Ns      ->      number of simulations in t={0:tFinal} 
%       scale   ->      ... 
%       tolIn   ->      tolerance to accept:  'inside BOA'
%       tolOut  ->      truncation tolerance: 'outside BOA' 
%       Nm      ->      number of messages displayed
%_________________________________________________________________________
% Usage:
%          (either generates default or user spcified options)
%
%  problemOpt = setOptions            ->      for default options
%
%  problemOpt = setOptions(optSet)    -> sets options specified in optSet 
%   -! optSet = {optName1, optVal1,       ||usefull inside functions||
%                   ...            }      ||    optSet == varargin  ||
%
%  problemOpt = ...                   -> sets options specified in names
%   setOptions(optName1, optVal1, ...)        optName1, optName2, ...
%  



%% Default problem options

problemOpt = struct('g',        9.81, ... [m/s2]    costante gravitazionale
                    'M',        5,    ... [kg]      massa del carrello
                    'l',        1,    ... [m]       lunghezza delle aste
                    'm',        1,    ... [kg]      masssa corpo attaccato #1
                    'h',        1,    ... [kg/s]    coefficiente di attrito viscoso
                    'domEig',   3,    ... [1/s]     modulo dell'autovalore dominante
                    'tFinal',   20,    ... [s]       istante finale di simulazione
                    'maxDeg',   40,   ... [°]       massima deviazione iniziale dall'equilibrio
                    'Nth',      50, ...
                    'Ns',       20, ...
                    'scale',    1, ...
                    'tolIn',    1e-4, ...
                    'tolOut',   1e4, ...
                    'Nm',       10   ); 

%% Function option parsing

if isempty(varargin)
    % default values returned
    return

elseif length(varargin)==1
    % case: optSet passed by argument
    optSet = varargin{1};

else
    % case: optName1, optVal1, ... passed by arguments
    optSet = varargin;

end

%% Set desired problem options

% check usage
if mod(length(optSet),2)~=0
    error('optSet can only have odd number of elements: optName, optVal, ...')
end

% extract names
nameIndex = 1:2:length(optSet);
optName = fieldnames(problemOpt);


% double loop over extracted names
checkNames = 0;
for ii = nameIndex
    for jj = 1:length(optName)

        % check position
        if isequal(optSet{ii},optName{jj})

            % assign value
            problemOpt.(optSet{ii}) = optSet{ii+1};
            
            % check at least one assignement
            checkNames = checkNames+1;

            % go to the next name to set
            break

        end
    end
end

% check correctness of option names
if and(checkNames==0, ~isempty(varargin{1}))
    error('Option name inserted not valid')
end


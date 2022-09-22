function writeOptions(problemOpt,varargin)
%%              writeOptions( problemOpt, ... )
%
% Literally, writes options fields in the caller workspace, this will work
% also for any kind of 'struct' as input in problemOpt.
%
%   'problemOpt' is a struct generated through setOptions:
%                   problemOpt = setOptions( ... )
%    ( type 'help setOptions')
% ________________________________________________________________________
% ! NOTE !
%   If a new field is defined externally
%       i.e.
%           opt = setOptions;
%           opt.(newFieldName) = newFieldVal;
%
%   writeOptions will not comply if 'newFieldName' is contained in the
%   function options.
%_________________________________________________________________________
% Usage:
%
%   writeOptions(problemOpt)           ->  writes all problemOpt fields
%
%   writeOptions(problemOpt, range)    ->  writes all problemOpt fields
%        -! range = [a, b]
%           where a,b = 'double'
%
%   writeOptions(problemOpt, optNames) ->  writes option field specified  
%        -! optNames = 'cell'                       in optNames
%
%   writeOptions(problemOpt, optName1, ->  writes option fields 
%                            optName2,     optVal1, optVal2, ...
%                               ...    ) 
%
%   writeOptions(setOptions( ... ),    ->  writes option fields generated
%                    __    )               throgh:    setOptions( ... )                      

% get names of possible options
varnames = fieldnames(problemOpt);

if isempty(varargin)
    % default: - it writes all options in the workspace
    for ii = 1:length(varnames)
        assignin('caller', varnames{ii}, problemOpt.(varnames{ii}))
    end

elseif isequal(class(varargin{1}),'double')
    % case: 'range' argument passed by argument
    for ii = varargin{1}(1):varargin{1}(2)
        assignin('caller', varnames{ii}, problemOpt.(varnames{ii}))
    end

elseif isequal(class(varargin{1}),'cell')
    if isequal(class(varargin{1}{1}),'double')
        % case: 'range' argument passed via varargin
        for ii = varargin{1}{1}(1):varargin{1}{1}(2)
            assignin('caller', varnames{ii}, problemOpt.(varnames{ii}))
        end
    else
        % case: 'optNames' argument passed via varargin
        optNames = varargin{1};
        for ii = 1:length(optNames)
            assignin('caller', optNames{ii}, problemOpt.(optNames{ii}))
        end
    end

elseif or(  isequal(class(varargin{1}),'char'), ...
            isequal(class(varargin{1}),'string'))
    % case: 'optName1, optName2, ...' arguments passed by argument
    for ii = 1:length(varargin)
        assignin('caller', varargin{ii}, problemOpt.(varargin{ii}))
    end

end



% Ek80 initialization and configuration file
%
%
%  Must run first
%
%     Sets up input and output data folders
%
%   This should be edited by the user to point
%     to data and software folders for this run.
%
%
%  DO NOT CHANGE VARIABLE NAMES
%
%
%    Change Num_parallel_workers
%    Change  DataFilePath
%    Change matlab and plotting output paths
%
% 
%        Other settings should be OK as is, but change
%           if you want
% --------------------------------------------------

% start fresh
clear; 
close all

% Version = 'V3';         % 2016-2019
Version = 'V4';         % 2020
 
WorkDir  = [pwd '/'];   % MUST end with slash 

% set to 0 if no parallelization wanted
Num_parallel_workers =  6; % 32 ; % 0;           %  set up matlab parallel features

addpath([WorkDir 'EK80/'])                  % utility programs folder, end with slash
addpath([WorkDir 'EK80_software/'])         % routines special/modified
addpath([WorkDir 'extras/'])                % extra routines


% Path to input .raw files for processing, MUST end with slash
%    if using GUI, will use as repository, not input files
if ~exist([WorkDir 'Data/'])
    fprintf('\t  Making %s\n', [WorkDir 'Data/']);
    mkdir([WorkDir 'Data/'])
end
DataFilePath = [WorkDir 'Data/'];  

% ---------------------------------------------------------------- 

% path to folder that will contain .mat files that hold processed data
MatOutDir = 'F:\jellyfish\ek80\calibration\ES70_38mm\depth_1.5m\';  

% path to folder that will hold images and plots. End with a slash
PlotOutDir =  [DataFilePath 'proc_plots/'];


% check if data dir exists
if ~exist(DataFilePath,'dir')
       error(['Cannot find ' DataFilePath]);
end
 
% check if the others exist
if ~exist(MatOutDir,'dir')
       mkdir(MatOutDir);
end

if ~exist(PlotOutDir,'dir')
       mkdir(PlotOutDir);
end

% ----------------------------------------------------------------------- 


% --------------------------------------------------------------
% EK80_main
%
%   Main routine
%
%   Main matlab routines to run processing in order, 
%       includes parallel processing
%
%   Can follow the function order for processing 
%
% ----------------------------------------------------------

%% ---------------------------------------------------------
%   Initialize
%        
%    Edit this file FIRST then run
%
%    Set ups working space and input/output directories
% ----------------------------------------------------------
    fprintf('Initializing.... \n');

 EK80_init  


%% ---------------------------------------------------------
%   Start Parallel
%
%       parallation is optional, 
%           will run in serial if Num_parallel_workers is 0
%
%   Num_parallel_workers set in init file        
% ----------------------------------------------------------
fprintf('Start Parallelization\n');
    
    Pool = Start_parallel(Num_parallel_workers);
 
%% --------------------------------------------------------
% read, pulsecompress, save data in .mat files
% 
%   Initialization program MUST be run first
%
%   This may take awhile... so be patient
% ---------------------------------------------------------

     
    if (exist('Pool') && Pool ~= 0)       % if Pool has workers do parallel
        
        fprintf('Running Parallel\n');
        EK80_read_proc_data_par;       % do ALL files selected in parallel
         
    else
        
        fprintf('Running Serial\n');        
        EK80_read_proc_data;            % not parallel
          
    end
    
 
%% --------------------------------------------------------
%   OPTIONAL:  Plot all images from .mat files
%
%  Plots ALL files, unless it is modified and/or made into
%       a function...  Does the data check section on all 
%       files that were processed.
% ---------------------------------------------------------

run_plotting = 0;

if run_plotting

    Plot_processed_files_GUI_select;      % select by hand with GUI
    % Plot_processed_files_all;    % through all files
end


%% --------------------------------------------------------
%   Optional: Plot all locations of signals
% 
%  If GPS positions are available
%
%   Also saves kml files for google earth
% ---------------------------------------------------------

if 0
    % save the file to disk? 
    % % save_files = 0;

    % run program
    [DTLat DTLon]= Plot_LatLons(MatOutDir,PlotOutDir, save_files);
   
    % plot_locations_track_ge
 
end

%% --------------------------------------------------------
 

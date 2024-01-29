function  [DTLat DTLon] = Plot_LatLons(MatOutDir, PlotOutDir, save_plots)
%      function    Plot_LatLons(MatOutDir, PlotOutDir, FileNameString, PlotFileName, save_plots)
%
%  save_plots argument is flag to save images (1) or not (0)
%
%    plots locations of signals taken during CTRiver2017_DT
%
%  Locations of data and output folders are hardwired for now
%
%
% -----------------------------------------------------------



% PlotOutDir = '/data2/Andone/EK80_Processing_CTRiver2017_DT/CTRiverDT_proc_plots/'; % end with slash
PlotFileName = 'All_signal_locations.png';

% MatOutDir =  '/data2/Andone/EK80_Processing_CTRiver2017_DT/CTRiverDT_matfiles/';  % end with slash
Files = dir([MatOutDir '*ES*.mat']);   % get info from one or another


% --------------------------------------------------------------------------

DTLat = [];
DTLon = [];


for ifile = 1:length(Files)
    filename = Files(ifile).name;
    load([MatOutDir '/' filename]);
    fprintf('Working on %d of %d - %s\n',ifile, length(Files), filename);
    
    % positions are stored in deg*100 ??   maybe for some runs... check
    %  Lat = Lat/100;
    %  Lon = Lon/100;
    
    DTLat = [DTLat; Lat'];
    DTLon = [DTLon; Lon'];
    
    if ~isempty(DTLat)
        figure(1)
        plot(Lon,Lat,'.');
        h = gca;
        h.DataAspectRatio = [1 cos(DTLat(1)/180*pi) 1];
        grid on;
        xlabel('Longitude'); ylabel('Latitude');
        title(filename(1:end-4),'interpreter','none' );
        
        if save_plots
            print('-dpng',[PlotOutDir filename(1:end-4) '_locations.png' ]);
        end
        
        
        
        figure(11); clf;
        plot(DTLon,DTLat,'.');
        h = gca;
        h.DataAspectRatio = [1 cos(DTLat(1)/180*pi) 1];
        grid on;
        xlabel('Longitude'); ylabel('Latitude');
        title('');
        
    end
    
    drawnow;
end

if save_plots
    figure(11); print('-dpng',[PlotOutDir PlotFileName]);
end

 
end

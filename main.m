%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                           
% Main script for the loosely-coupled feedback GNSS-aided INS system. 
%  
% Edit: Isaac Skog (skog@kth.se), 2016-09-06
% Revised: Idriss Riouak (idriss.riouak@cs.lth.se) 27/03/2020
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear 
disp('Loads data')
load('GNSSaidedINS_data.mat');

%%% Remove comments to find the best speed and nonholo parameters

%finalerr = Inf;
%finalnonholo = 0;
%finalspeed = 0;
%for speed = 2:0.001:2.02
%    speed
%    errors = ones(3,50)*Inf;
%    parfor nonholo = 95:105
        %% Load filter settings
        %disp('Loads settings')
        settings=get_settings();
%        factor = nonholo/10;
%        settings.sigma_non_holonomic =factor;
%        settings.sigma_speed = speed;

        %% Run the GNSS-aided INS
        %disp('Runs the GNSS-aided INS')
        out_data=GPSaidedINS(in_data,settings);

        %% Plot the data 
        %disp('Plot data')
        err = plot_data(in_data,out_data,'True');drawnow
 %       close all
 %       errors(:,nonholo-84)=[err;factor;speed];
 %   end
 %  "Minimo locale"
 %  [M, I] = min(errors(1,:))
 %  if errors(1,I)< finalerr 
 %      finalerr = errors(1,I)
 %      finalnonholo = errors(2,I)
 %      finalspeed = errors(3,I)
 %  end
 %  
%end






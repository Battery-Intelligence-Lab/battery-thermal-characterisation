function [Res,ResT,a_mod] = ObjFunc(x)
%% Load EXPERIMENTAL Data
load Exp.mat % To be adjusted
% Exp.mat contains an 3D matrix (E) for spatiotemporal cell surface temperature
% The matrix contains 11*11 grid, "xe" and "ye" vectors denote their locations
[~,~,nt]=size(E); 
Tavg_exp(:)=mean(E,[1 2]); % average temperture
Thot_exp(:)=E(6,6,:); % hot spot temperature
xhot=xe(6); % x-axis (length coordinate) for hot spot 
yhot=ye(6); % y-axis (width coordinate) for hot spot

%% Define variables
global xbest Fobjbest

ts       = nt-1; % time
kx       = x(1); 
ky       = x(2);
kz       = x(3);
ha       = x(4);


%% Run COMSOL Model
Batterymodel(kx,ky,kz,ha,ts,xhot,yhot);
% Convert COMSOL simulation results to a model matrix similar to experiment
Simmatrix


%% Load SIMULATION Results
load Sim.mat; % To be adjusted#
Tavg_sim(:)=mean(M,[1 2]); % average temperture
Thot_sim(:)=M(6,6,:); % hot spot temperature
close all


%% Calculate RESIDUALS
Res=(M(:,:,30:end)-E(:,:,30:end))./E(:,:,30:end);
ResT=Res(:);
Fobj=sum(ResT.^2);

if Fobj<Fobjbest
    xbest    = x;
    Fobjbest = Fobj;
    save('last_res','xbest','Fobjbest')
end

%% PLOT EXP and SIM Results
tf=0:1:ts;
figure(1)
plot(tf,Thot_exp,'-g',tf,Tavg_exp,'-g',tf,Thot_sim,'-b',tf,Tavg_sim,'-b','linewidth',2)
xlabel('Time (s)','fontsize',16)
ylabel('Temperature (\circC)','fontsize',16)
xlim([0 ts])
title(['x =' num2str(x) 'Res = ' num2str(Fobj)],'fontsize',16)
x
Fobj
pause(0.1)

% end
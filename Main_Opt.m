% Therml characterization with lock-in thermography data 
% Anisotropic thermal diffusivity (kx, ky, kz) and heat transfer coefficienct (ha)

clc
clearvars -except xbest
close all
format short g

global xbest Fobjbest 
Fobjbest = 1e5;
iter = 0;
% Initial values
%      kx     ky      kz      ha
x0 = [0.49   25.17   25.25 17.74]; 
lb = [0.0     0.0    0.0     0.0]; % lower bound
ub = [10.0    50     50     30.0]; % upper bound

%% Start optimization
options  = optimset('display','iter','MaxFunEvals',1000,'TolX',1e-4,'FinDiffRelStep',1e-2);
[x fval] = lsqnonlin(@ObjFunc,x0,lb,ub,options)

% [Res,ResT] = ObjFunc(x0);


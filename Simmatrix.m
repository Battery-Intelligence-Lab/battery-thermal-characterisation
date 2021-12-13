% clear all
% Read COMSOL data txt and convert to simulation matrix for validation
function Simmatrix

load Exp.mat
[nx,ny,nt]=size(E);
%% Read COMSOL data txt
filename='Sim-Tsurf.txt'; % Define txt spreadsheet to be processed
opts = detectImportOptions(filename); % Define readtable options
opts = delimitedTextImportOptions('NumVariables',nt+2);
opts = setvartype(opts,'double'); % Set variable type to be double
opts.VariableNamesLine=9;
opts.DataLines=[10 Inf]; % Read datalines from 10
opts.ConsecutiveDelimitersRule='join';
opts.Delimiter ={' '};
S=readtable(filename,opts); % Read txt spreadsheet 
[~,my]=size(S);

%% Fit simulation into validation matrix
x0=S{:,1}; % Get x dimension
y0=S{:,2}; % Get y dimension
x=xe; % Get x for temperature matrix from exp
y=ye; % Get y for temperature matrix from exp
[X,Y]=meshgrid(x,y);
M=zeros(nx,ny,my-2);
for i=1:my-2
    z0=S{:,i+2};
    M(:,:,i)=griddata(x0,y0,z0,X,Y,'v4'); % Generate sim matrix
end
    save Sim.mat M
    fclose('all');
end

% %% Convert data into 
% cmap = cmocean('thermal');
% figure
% imagesc(x,y,Z(:,:,end));
% colormap (cmap)
% colorbar;
% ax=gca;
% ax.YDir = 'normal';
% xlabel('Battery width (mm)')
% ylabel('Battery length (mm)')

% end

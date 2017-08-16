% This Matlab script is written to plot figures for the Faraday spin
% sqeezing protocol paper by Xiaodong Qi, Yuan-Yu Jau and Ivan H Deutsch.
% 
% By Xiaodong Qi, 2017-08-15.

clear all
close all

% Define default parameters for plots.
lw=1.5;        % Line width. Use 2 for presentations.
fgwidth = 3;     % Width in inches. Default value is 5.6.
fgheight = 3;    % Height in inches. Default value is 4.2.
alw = 0.75;    % AxesLineWidth. Use 1 for presentations.
fsz = 11;      % Fontsize. Use 14 for presentations.
msz = 8;       % MarkerSize. Use 12 for presentations.
% The properties we've been using in the figures
set(0,'defaultLineLineWidth',lw);   % set the default line width to lw
set(0,'defaultLineMarkerSize',msz); % set the default line marker size to msz
set(0,'defaultLineLineWidth',lw);   % set the default line width to lw
set(0,'defaultLineMarkerSize',msz); % set the default line marker size to msz

% Set the default Size for display
defpos = get(0,'defaultFigurePosition');
set(0,'defaultFigurePosition', [defpos(1) defpos(2) fgwidth*100, fgheight*100]);

% Set the defaults for saving/printing to a file
set(0,'defaultFigureInvertHardcopy','on'); % This is the default anyway
set(0,'defaultFigurePaperUnits','inches'); % This is the default anyway
defsize = get(gcf, 'PaperSize');
left = (defsize(1)- fgwidth)/2;
bottom = (defsize(2)- fgheight)/2;
defsize = [left, bottom, fgwidth, fgheight];
set(0, 'defaultFigurePaperPosition', defsize);

%% Plots for effective mode areas and cooperativity in the xy-plane for the square waveguide case.
load('../data/swg_modes_d300_lambda895_Aeff.mat');
figure(51);
% colormap(hot)
% subplot(234)
% imagemode(xc_full/d,yc/d,A_Far/max(A_Far(:)));% Intensity of H mode.
contour(xxc./d,yyc./d,invA_Far/max(invA_Far(:)),Nline);
% title(sprintf('1/A_{Far}'));
hold on
line(x_border/d,y_border/d,'Color','k');
axis equal
% xlim([min(xc_full),max(xc_full)]/d);
% ylim([min(yc),max(yc)]/d);
xlim([-1.5,1.5]);
ylim([-1.5,1.5]);
% colorbar('WestOutside')
cleanfigure;
matlab2tikz('filename','../fig/swg_invA_Far_xy.tex','floatFormat','%.4f');
hold off

figure(52);
% colormap(hot)
% subplot(234)
% imagemode(xc_full/d,yc/d,A_in/max(A_in(:)));% Intensity of H mode.
contour(xxc./d,yyc./d,invA_in/max(invA_in(:)),Nline);
% title(sprintf('1/A_{in}'));
hold on
line(x_border/d,y_border/d,'Color','k');
axis equal
xlim([-1.5,1.5]);
ylim([-1.5,1.5]);
% colorbar('WestOutside')
cleanfigure;
matlab2tikz('filename','../fig/swg_invA_in_xy.tex','floatFormat','%.4f');
hold off

figure(53);
% colormap(hot)
% subplot(234)
% imagemode(xc_full/d,yc/d,A_Far/max(A_Far(:)));% Intensity of H mode.
[Cm,hdl] = contour(xxc./d,yyc./d,C1,Nline);%./max(C1(:))
% title(sprintf('C_1'));
hold on
line(x_border/d,y_border/d,'Color','k','linewidth',lw);
fprintf('Please use the mouse to pick out the places to label the levels. Press RETURN to terminate.');
% vl = [8.595e-5,1.7e-4];% Levels to be labeled. Replace 'manual' with vl in the command below if these lines are meant to be labeled automatically.
clabel(Cm,hdl,'manual','LabelSpacing',300,'FontSize',9,'color','b','BackgroundColor','w','Margin',1)
axis equal
xlim([-1.2,1.2]);
ylim([-1.2,1.2]);
yticks([-1.0,-0.9,-0.8,-0.7,-0.5,0,0.5,1.0,1.2])
yticklabels({'-1.0','-0.9','-0.8','-0.7','-0.5','0','0.5','1.0','1.2'});
colorbar('EastOutside')
line([-1.2,0],[-1.0,-1.0],'linestyle','--','Color',[0.1,0.1,0.1],'linewidth',0.5);
line([-1.2,0],[-0.9,-0.9],'linestyle','--','color',[0.2,0.2,0.2],'linewidth',0.5);
line([-1.2,0],[-0.8,-0.8],'linestyle','--','color',[0.3,0.3,0.3],'linewidth',0.5);
line([-1.2,0],[-0.7,-0.7],'linestyle','--','color',[0.4,0.4,0.4],'linewidth',0.5);
cleanfigure;
matlab2tikz('filename','../fig/swg_C1_xy.tex','floatFormat','%.4f');
hold off

figure(54);
plot(y_atom/d,C1_atom,'k-');
hold on
% title('C_1(r)')
xlabel('r_\perp/d')
ylabel('C_1')
xlim([0.59,1.5])
cleanfigure;
matlab2tikz('filename','../fig/swg_C1_y.tex','floatFormat','%.4f');
hold off

%% Plot effective mode areas and cooperativity parameters for the nanofiber case.
clear all
load('../data/nanofiber_modes_a225_lambda895_Aeff.mat')

cgstep=2; % Step length for the Coarse-grain of the data in plots.

figure(401);
% colormap(hot)
% subplot(234)
% imagemode(x/a,y/a,A_Far/max(A_Far(:)));% Intensity of H mode.
contour(xx(1:cgstep:end,1:cgstep:end)./a,yy(1:cgstep:end,1:cgstep:end)./a,invA_Far(1:cgstep:end,1:cgstep:end)/max(invA_Far(:)),Nline);
% title(sprintf('1/A_{Far}'));
hold on
viscircles([0,0],1,'Color','k');
axis equal
xlim([-2.2,2.2]);
ylim([-2.2,2.2]);
% colorbar('WestOutside')
cleanfigure;
matlab2tikz('filename','../fig/nanofiber_invA_Far_xy.tex','floatFormat','%.4f');
hold off

figure(402);
% colormap(hot)
% subplot(234)
% imagemode(x/a,y/a,A_in/max(A_in(:)));% Intensity of H mode.
contour(xx(1:cgstep:end,1:cgstep:end)./a,yy(1:cgstep:end,1:cgstep:end)./a,invA_in(1:cgstep:end,1:cgstep:end)/max(invA_in(:)),Nline);
% title(sprintf('1/A_{in}'));
hold on
viscircles([0,0],1,'Color','k');
axis equal
xlim([-2.2,2.2]);
ylim([-2.2,2.2]);
% colorbar('WestOutside')
cleanfigure;
matlab2tikz('filename','../fig/nanofiber_invA_in_xy.tex','floatFormat','%.4f');
hold off

figure(403);
% colormap(hot)
% subplot(234)
% imagemode(x/a,y/a,A_Far/max(A_Far(:)));% Intensity of H mode.
[Cm,hdl] = contour(xx(1:cgstep:end,1:cgstep:end)./a,yy(1:cgstep:end,1:cgstep:end)./a,C1(1:cgstep:end,1:cgstep:end),Nline);%./max(C1(:))
% title(sprintf('C_1'));
hold on
viscircles([0,0],1,'Color','k');
fprintf('Please use the mouse to pick out the places to label the levels. Press RETURN to terminate.');
% vl = [8.595e-5,1.7e-4];% Levels to be labeled. Replace 'manual' with vl in the command below if these lines are meant to be labeled automatically.
clabel(Cm,hdl,'manual','LabelSpacing',300,'color','b','BackgroundColor','w','Margin',1)%'FontSize',9,
axis equal
colorbar('EastOutside')
xlim([-2.2,2.2]);
ylim([-2.2,2.2]);
yticks([-2.0,-1.8,-1.5,-1,0,0.5,1.0,1.5,2.0])
yticklabels({'-2.0','-1.8','-1.5','-1.0','0','0.5','1.0','1.5','2.0'});
colorbar('EastOutside')
line([-2.2,0],[-2.0,-2.0],'linestyle','--','Color',[0.1,0.1,0.1],'linewidth',0.5);
% line([-2.2,0],[-1.9,-1.9],'linestyle','--','color',[0.2,0.2,0.2],'linewidth',0.5);
line([-2.2,0],[-1.8,-1.8],'linestyle','--','color',[0.3,0.3,0.3],'linewidth',0.5);
line([-2.2,0],[-1.5,-1.5],'linestyle','--','color',[0.4,0.4,0.4],'linewidth',0.5);
cleanfigure;
matlab2tikz('filename','../fig/nanofiber_C1_xy.tex','floatFormat','%.4f');
hold off

figure(404);
plot(r_atom/a,C1_r,'k-');
hold on
% title('C_1(r)')
xlabel('r_\perp/a')
ylabel('C_1')
xlim([1.1,2.2])
cleanfigure;
matlab2tikz('filename','../fig/nanofiber_C1_y.tex','floatFormat','%.4f');
hold off

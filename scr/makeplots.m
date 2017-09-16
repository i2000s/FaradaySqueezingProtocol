% This Matlab script is written to plot figures for the Faraday spin
% sqeezing protocol paper by Xiaodong Qi, Yuan-Yu Jau and Ivan H Deutsch.
% 
% The data sets are generated by the following codes in the QIP package
% versioned on 2017-09-15:
% 1. Waveguidemodes/rectwg_TETMlow_fullvector.m --> SWG Aeff;
% 2. NanofiberTrappedCsAtoms/Example_FiberModeProfile.m --> nanofiber Aeff;
% 3. NanofiberTrappedCsAtoms/Example_SpinSqueezing_FaradaySCS_nanofiber.m
% --> peak $\xi^{-2}$ of nanofiber;
% 4. NanofiberTrappedCsAtoms/Example_SpinSqueezing_FaradaySCS_SWG.m
% --> peak $\xi^{-2}$ of SWG;
% 5. NanofiberTrappedCsAtoms/QutritFaradaySqueezing/
% SpinSqueezing_Faraday_SCS_qutrit_generalgamma.m --> spin squeezing
% dynamics with the nanofiber;
% 6. IntegratedWaveguideTrappedCsAtoms/Squarewg/
% SpinSqueezing_Faraday_SCS_CsD1_qutrit_squarewg.m --> spin squeezing
% dynamics with the SWG.
% 
% By Xiaodong Qi, 2017-08-15.

clear all
close all

% Define default parameters for plots.
lw=1.5;        % Line width. Use 2 for presentations.
fgwidth = 3;     % Width in inches. Default value is 5.6.
fgheight = 3;    % Height in inches. Default value is 4.2.
alw = 0.75;    % AxesLineWidth. Use 1 for presentations.
fs = 11;      % Fontsize. Use 14 for presentations.
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
xlim([-1.2,1.2]);
ylim([-1.2,1.2]);
% colorbar('WestOutside')
cleanfigure;
matlab2tikz('filename','../fig/swg_invA_Far_xy.tex','floatFormat','%.4f','showInfo', false, ...
        'parseStrings',false,'standalone', false, ...
        'height', '1.4in', 'width','1.4in');
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
xlim([-1.2,1.2]);
ylim([-1.2,1.2]);
% colorbar('WestOutside')
cleanfigure;
matlab2tikz('filename','../fig/swg_invA_in_xy.tex','floatFormat','%.4f','showInfo', false, ...
        'parseStrings',false,'standalone', false, ...
        'height', '1.4in', 'width','1.4in');
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
matlab2tikz('filename','../fig/swg_C1_xy.tex','floatFormat','%.4f','showInfo', false, ...
        'parseStrings',false,'standalone', false, ...
        'height', '3.0in');
hold off

figure(54);
plot(y_atom/d,log10(C1_atom),'r-');
hold on
% title('C_1(r)')
xlabel('$r_\perp/d$')
ylabel('$\log_{10}(C_1)$')
xlim([0.5,2.0])
ylim([-2.4,0.5])
grid on
cleanfigure;
matlab2tikz('filename','../fig/swg_C1_y.tex','floatFormat','%.4f','showInfo', false, ...
        'parseStrings',false,'standalone', false, ...
        'height', '5cm', 'width','6cm');
hold off

%% Plot effective mode areas and cooperativity parameters for the nanofiber case.
load('../data/nanofiber_modes_a225_lambda895_Aeff.mat')

cgstep=1; % Step length for the Coarse-grain of the data in plots.

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
matlab2tikz('filename','../fig/nanofiber_invA_Far_xy.tex','floatFormat','%.4f','showInfo', false, ...
        'parseStrings',false,'standalone', false, ...
        'height', '1.4in', 'width','1.4in');
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
matlab2tikz('filename','../fig/nanofiber_invA_in_xy.tex','floatFormat','%.4f','showInfo', false, ...
        'parseStrings',false,'standalone', false, ...
        'height', '1.4in', 'width','1.4in');
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
matlab2tikz('filename','../fig/nanofiber_C1_xy.tex','floatFormat','%.4f','showInfo', false, ...
        'parseStrings',false,'standalone', false, ...
        'height', '3.0in');
hold off

figure(404);
ind_rstart=find(r_atom/a>1.0,1,'first');
plot(r_atom(ind_rstart:end)/a,log10(C1_r(ind_rstart:end)),'r-');
hold on
% title('C_1(r)')
xlabel('$r_\perp/a$')
ylabel('$\log_{10}(C_1)$')
xticks([1.0,1.5,1.8,2.0,2.5])
xticklabels({'1.0','1.5','1.8','2.0','2.5'});
xlim([1.0,2.5])
ylim([-1.4,-0.2])
grid on
cleanfigure;
matlab2tikz('filename','../fig/nanofiber_C1_y.tex','floatFormat','%.4f','showInfo', false, ...
        'parseStrings',false,'standalone', false, ...
        'height', '5cm', 'width','6cm');
hold off

%% Peak squeezing as a function of NA and atom position for both Nanofiber and SWG.
load('../data/nanofiber_peakxi_a225_lambda895.mat');

figure(501); % For the peak spin squeezing parameter using the full dynamics as a function of $r_\perp$.
plot(rp0_test/a_fiber,xi_peak(5,:),'r-','linewidth',lw);
xlabel('$r_\perp/a$');
ylabel('$\xi^{-2}_{peak}$ (dB)');
hold on
xlim([1.0,2.5])
% ylim([0,15])
xticks([1.0,1.5,1.8,2.0,2.5])
xticklabels({'1.0','1.5','1.8','2.0','2.5'});

grid on
set(gca,'fontsize',fs)
cleanfigure;
matlab2tikz('filename','../fig/nanofiber_peakxi_rp_NA2500.tex','floatFormat','%.4f','showInfo', false, ...
        'parseStrings',false,'standalone', false, ...
        'height', '5cm', 'width','6cm');
hold off

% Plot the peak spin squeezing parameter as a function of NA.
figure(502);
plot(NAlist,xi_peak(:,ind_atomposition)','r-','linewidth',lw);
xlabel('$N_A$');
ylabel('$\xi^{-2}_{peak}$ (dB)');
hold on
xlim([500,5000])
ylim([2.8,9])
xticks([500,1500,2500,3500,4500])
xticklabels({'500','1500','2500','3500','4500'});
yticks([3,5,7,9])
yticklabels({'3','5','7','9'});
grid on
set(gca, 'fontsize',fs);
cleanfigure;
matlab2tikz('filename','../fig/nanofiber_peakxi_NA_rp1d8a.tex','floatFormat','%.4f','showInfo', false, ...
        'parseStrings',false,'standalone', false, 'interpretTickLabelsAsTex', true, ...
        'height', '5cm', 'width','6cm');
hold off

load('../data/swg_peakxi_d300_lambda895.mat')

figure(503); % For the peak spin squeezing parameter using the full dynamics as a function of $r_\perp$.
deltaa=2; % Step to select $r_\perp$ for a smooth curve.
plot(rp0_test(1:deltaa:end)/d_wg,xi_peak(5,1:deltaa:end),'r-','linewidth',lw);
xlabel('$r_\perp/d$');
ylabel('$\xi^{-2}_{peak}$ (dB)');
hold on
xlim([0.5,2.0])
% ylim([0,15])
xticks([0.5,1.0,1.5,2.0])
xticklabels({'0.5','1.0','1.5','2.0'});

grid on
set(gca,'fontsize',fs)
cleanfigure;
matlab2tikz('filename','../fig/swg_peakxi_rp_NA2500.tex','floatFormat','%.4f','showInfo', false, ...
        'parseStrings',false,'standalone', false, ...
        'height', '5cm', 'width','6cm');
hold off

figure(504); % For the peak spin squeezing parameter using the full dynamics as a function of NA.
plot(NAlist,xi_peak(:,ind_atomposition)','r-','linewidth',lw);
xlabel('$N_A$');
ylabel('$\xi^{-2}_{peak}$ (dB)');
hold on
xlim([500,5000])
ylim([9,16])
xticks([500,1500,2500,3500,4500])
xticklabels({'500','1500','2500','3500','4500'});
yticks([10,12,13,14,16])
yticklabels({'10','12','13','14','16'});
grid on
set(gca,'fontsize',fs)
cleanfigure;
matlab2tikz('filename','../fig/swg_peakxi_NA_rp1d.tex','floatFormat','%.4f','showInfo', false, ...
        'parseStrings',false,'standalone', false, 'interpretTickLabelsAsTex', true, ...
        'height', '5cm', 'width','6cm');
hold off

%% Plot spin squeezing parameter as a function of time.

% Plot the best spin squeezing process for nanofiber.
load('../data/nanofiber_xi_t_a225_lambda895_rp1d8a_NA2500.mat');
figure(601);
plot(tlist(1:steptjump:end),xi_atom_rotatingframe(1:steptjump:end),'r-','linewidth',lw);
xlabel('$\gamma_st$');
ylabel('$\xi^{-2}$ (dB)');
hold on
xlim([0,0.02])
ylim([0,8])
yticks([0,3,5,7,8])
yticklabels({'0','3','5','7','8'});
grid on
set(gca, 'fontsize',fs);
cleanfigure;
matlab2tikz('filename','../fig/nanofiber_xi_t_rp1d8a_NA2500.tex','floatFormat','%.4f','showInfo', false, ...
        'parseStrings',false,'standalone', false, ...
        'height', '5cm', 'width','6cm');
hold off

% Plot the best spin squeezing process for nanofiber.
load('../data/swg_xi_t_d300_lambda895_rp1d_NA2500.mat');
figure(602);
plot(tlist(1:steptjump:end),xi_atom_rotatingframe(1:steptjump:end),'r-','linewidth',lw);
xlabel('$\gamma_st$');
ylabel('$\xi^{-2}$ (dB)');
hold on
xlim([0,0.02])
% ylim([0,8])
yticks([0,5,10,13,15])
yticklabels({'0','5','10','13','15'});
grid on
set(gca, 'fontsize',fs);
cleanfigure;
matlab2tikz('filename','../fig/swg_xi_t_rp1d_NA2500.tex','floatFormat','%.4f','showInfo', false, ...
        'parseStrings',false,'standalone', false, ...
        'height', '5cm', 'width','6cm');
hold off
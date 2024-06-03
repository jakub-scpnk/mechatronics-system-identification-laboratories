% author: Jakub Szczepaniak
% date: 14/05/2024

%% Task 1.1

% displaying the bode plots based on theoretical transmittance

% physical data
RC.name = "RC";
RC.R = 47;      % [Ohm]
RC.C = 2.2e-6;  % [F]
RC.L = NaN;     % [H]
RLC.name = "RLC";
RLC.R = 220;    % [Ohm]
RLC.C = 4.7e-9; % [F]
RLC.L = 1e-3;   % [H]

% numerators and denominators 
RC.num = 1/(RC.R*RC.C); 
RC.den = [1 1/(RC.R*RC.C)]; 
RLC.num = [(RLC.R/RLC.L) 0]; 
RLC.den = [1 (RLC.R/RLC.L) (1/(RLC.C*RLC.L))]; 

% transfer functions
RC.sys = tf(RC.num,RC.den);
RLC.sys = tf(RLC.num,RLC.den);

iter = 1;
% plotting bode plots with bode function 
for system = [RC, RLC]
    figure
    h = bodeplot(system.sys);
    setoptions(h,'FreqUnits','Hz','PhaseVisible','off','Grid','on');
    title('Magnitude Bode Plot for ' + system.name + ' system')
    
    % limiting frequency axis to area of excitation
    if system.name == "RC"
        xlim([40, 150000])
    else
        xlim([1000, 300000])
    end
    saveas(gcf,['figures/lab_5_task_1_fig_',num2str(iter),'.png'])
    iter = iter+1;
end

% displaying bode plots based on experimental data
for system = [RC, RLC]
    
    % loading signal
    if system.name == "RC"
        load('dane-pomiarowe/20210305-RC_Chirp40v150kHz_T2s.mat')
    else
        load('dane-pomiarowe/20220401-RLC_Chirp1v300kHz_T2s.mat')
    end

    % sampling frequency
    fs = 1/Tinterval;

    % removal of Inf and NaN
    A(isnan(A)) = 0;
    B(isnan(B)) = 0;
    A(isinf(A)) = 0;
    B(isinf(B)) = 0;

    % spectral transmittances
    H = fft(A)./fft(B);

    % saving spectral transmittance
    if system.name == "RC"
        RC.H = H;
    else
        RLC.H = H;
    end

    % frequency vector
    fv = (0:Length-1) * fs/Length;

    % Bode plot
    figure
    semilogx(fv, 20*log10(abs(H)))
    grid on
    xlabel('frequency [Hz]')
    ylabel('magnitude [dB]')
    title('Magnitude Bode plot for ' + system.name + ' system')
    subtitle('from experimental data, chirp excitation')

    % limiting frequency axis to area of excitation
    if system.name == "RC"
        xlim([40, 150000])
    else
        xlim([1000, 300000])
    end
    saveas(gcf,['figures/lab_5_task_1_fig_',num2str(iter),'.png'])
    iter = iter+1;
end

clear system iter A B ExtraSamples RequestedLength h

% calculating damping of RLC with Half-power method

% values red from the graph:
omega_r = 85507; % resonant frequency
omega_1 = 65796;
omega_2 = 112407;

% Half-power method
zeta = (omega_2 - omega_1)/(2*omega_r);

clear omega_r omega_1 omega_2

%% Task 1.2

RLC_2.R2 = 217;        % real value  
RLC_2.C2 = 4.1e-9;     % real value  
RLC_2.L2 = 0.83e-3;    % real value  
RLC_2.R2L = 25;        % real value  

RLC_2.num = [(RLC_2.R2/RLC_2.L2) 0]; 
RLC_2.den = [1 ((RLC_2.R2+RLC_2.R2L)/RLC_2.L2) (1/(RLC_2.C2*RLC_2.L2))];

RLC_2.sys = tf(RLC_2.num,RLC_2.den);

figure();

subplot(211)
% plotting bode plot from experimental data
p = semilogx(fv, 20*log10(abs(RLC.H)));
hold on
% ploting theoretical bode plot for real values
h = bodeplot(RLC_2.sys,'r');
setoptions(h,'FreqUnits','Hz','PhaseVisible','off','Grid','on')
xlim([1000, 300000])
title('Bode diagram for RLC circut')
legend('theoretical transmittance','Location','southeast')
legend('boxoff')
hold on

subplot(212)
% plotting bode plot from experimental data
p = semilogx(fv, 20*log10(abs(RLC.H)));
hold on
% ploting theoretical bode plot for real values
h = bodeplot(RLC_2.sys,'r');
setoptions(h,'FreqUnits','Hz','PhaseVisible','off','Grid','on')
title('Close view of the area near resonance frequency')
hold on
xlim([0.4e5, 1.5e5])
ylim([-20, 0])

saveas(gcf,'figures/lab_6_task_1_fig_6.png')

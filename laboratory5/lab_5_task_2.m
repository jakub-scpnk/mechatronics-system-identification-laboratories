% author: Jakub Szczepaniak
% date: 16.04.2024r

% note: The script requires about 45s to run, wait until MATLAB stop saying
% 'busy' in the lower left corner.
%% Task 2.1

R = 10;     % [Ohm]
L = 4e-6;   % [H]
C = 1e-6;   % [F]
dt = 1/1e6; % [s]

% RLC transfer function numerator and denominator
num = [L 0];
den = [R*L*C L R];
fig_num = 1; % Number of figure

for freq = [70, 80, 90]
    out = sim('lab_5_task_2_sim.slx');

    figure('Name','System response')
    plot(out.y1)

    % --- figure details ---
    xlabel('time [s]')
    ylabel('amplitude [-]')
    title(['System response for excitation with sine of frequency ', ...
        num2str(freq)])
    xlim([0,1])
    grid on
    saveas(gcf, ['figures/lab_5_task_2_fig_', num2str(fig_num),'.png'])
    fig_num = fig_num + 1;
    % --- figure details ---
end

%% Task 2.2

R = 10;     % [Ohm]
L = 4e-6;   % [H]
C = 1e-6;   % [F]
dt = 1/1e6; % [s]

% RLC transfer function numerator and denominator
num = [L 0];
den = [R*L*C L R];

% simulation
out=sim('lab_5_rlc_sim.slx');
H = out.y1;

% creating sine wave
A = 1;
freq =70;
t = out.tout;
sine_wave = A*sin(2*pi*t*freq);
SYS_response = conv(H,sine_wave);

plot(SYS_response)
grid on
ylabel 'amplitude [-]'
title 'Result of convolution of impulse response with sine wave'
%xlim([0,length(sine_wave)])
xlabel '[-]'
hold on;

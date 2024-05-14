% authors: Jakub Szczepaniak & Aleksandra Michalak
% date: 16.04.2024r

%% Task 1.1

R = 10;     % [Ohm]
L = 4e-6;   % [H]
C = 1e-6;   % [F]
dt = 1/1e6; % [s]

% RLC transfer function numerator and denominator
num = [L 0];
den = [R*L*C L R];

out=sim('lab_5_rlc_sim.slx');

SYS = tf(num,den); 

%% Task 1.2 - Creating bode plot

% Generate frequency vector
omega = logspace(1, 7, 1000); % Frequency range from 10 to 10^7 Hz

% Initialize magnitude and phase arrays
mag = zeros(size(omega));
phase = zeros(size(omega));

% Calculate frequency response manually
for i = 1:length(omega)
    s = 1j * omega(i);                     % Complex frequency
    H = polyval(num, s) / polyval(den, s); % Transfer function at freq s
    mag(i) = abs(H);                       % Magnitude
    phase(i) = angle(H) * (180 / pi);      % Phase in degrees
end

% Plot the Bode plot
figure;
subplot(211);
semilogx(omega, 20*log10(mag));
grid on;
xlabel('Frequency [Hz]');
ylabel('Magnitude [dB]');
title('Magnitude Bode Plot');
xlim([10^4 10^7]);

subplot(212);
semilogx(omega, phase);
grid on;
xlabel('Frequency [Hz]');
ylabel('Phase [deg]');
title('Phase Bode Plot');
xlim([10^4 10^7]);

save_fig2png(gcf,[16 9], 'figures/lab_5_task_1_fig_1');

% Displaying bode plot with built in function
figure;
bode(SYS)
save_fig2png(gcf,[16 9], 'figures/lab_5_task_1_fig_2');

% Calculating damping factor

% Logarithmic Method
impulse_response = out.y1;
peak_amplitude = max(impulse_response);
decay_rate = -20 / length(impulse_response); % Assuming the impulse
                                             % response decays linearly
A_n = peak_amplitude;
A_n1 = peak_amplitude * exp(decay_rate);
zeta_log = -log(A_n/A_n1) / sqrt(4*pi^2 + log(A_n/A_n1)^2);

% Half-Power Method
omega_d = omega(find(20*log10(mag) <= -3, 1));  % Frequency at -3dB point
omega_1 = interp1(20*log10(mag), omega, -3);    % Bandwidth frequency
zeta_half_power = 1 / sqrt(1 + (omega_1/(2*omega_d))^2);

disp(['Dimensionless damping factor (logarithmic method): ', ...
    num2str(zeta_log)]);
disp(['Dimensionless damping factor (half-power method): ', ...
    num2str(zeta_half_power)]);


%% Task 1.3

L = 4e-6;   % [H]
C = 1e-6;   % [F]
dt = 1/1e6; % [s]


for R = [5, 10, 100] % [Ohm]
    R = R;
    num = [L 0];       % transfer function numerator
    den = [R*L*C L R]; % transfer function denominator

    out=sim('lab_5_rlc_sim.slx'); % starting simulink model
    SYS = tf(num,den);

    % Displaying bode plot with built in function
    figure('Name', ['Bode plot R =', num2str(R)])
    bode(SYS); grid on;
    %save_fig2png(gcf,[16 9], ['figures/lab_5_task_1_bode_r_', num2str(R)]);

    % Calculating damping factor

    % Logarithmic Method
    impulse_response = out.y1;
    peak_amplitude = max(impulse_response);
    decay_rate = -20 / length(impulse_response); % Assuming the impulse 
                                                 % response decays linearly
    A_n = peak_amplitude;
    A_n1 = peak_amplitude * exp(decay_rate);
    zeta_log = -log(A_n/A_n1) / sqrt(4*pi^2 + log(A_n/A_n1)^2);

    % Half-Power Method
    omega_d = omega(find(20*log10(mag) <= -3, 1));% Frequency at -3dB point
    omega_1 = interp1(20*log10(mag), omega, -3);  % Bandwidth frequency
    zeta_half_power = 1 / sqrt(1 + (omega_1/(2*omega_d))^2);

    fprintf('\nFor resistance R = %d \n', R)
    fprintf('\nDimensionless damping factor (log method): %.4f', zeta_log)
    fprintf('\nDimensionless damping factor (half-power method): %.9f', ...
        zeta_half_power);
end

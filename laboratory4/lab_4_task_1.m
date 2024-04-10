% author: Jakub Szczepaniak
% date: 04.04.2024r

%% Task 1.1

[audio, fs] = audioread("twomicrophones2/twomicrophones1.wav");

t = (0:(length(audio(:,1)))-1)/fs; % time vector [s]

audio_comp_1 = audio(:,1) - mean(audio(:,1));
audio_comp_2 = audio(:,2) - mean(audio(:,2));

% you can take a look what happends without the compensation

[corr_result, lag] = xcorr(audio_comp_2,audio_comp_1);
tc = lag/fs;

% finding time dealy
[corr_peak, corr_index] = max(corr_result);
time_delay = tc(corr_index);

% calculating distance
v = 345; % [m/s]
dist = time_delay * v; % [m], m = v/s
fprintf('The calculated ditance from the speaker to microphone: %f [m] \n', dist);

figure('Name','Task 1.1: correlation' ,'NumberTitle','off')
plot(tc, corr_result);
xlabel('time [s]'); ylabel('amplitude [-]'); grid on
xlim([-0.02,0.02]); % limiting to area of interest

%% Task 1.2

Y = fft(audio_comp_2); % numerator
X = fft(audio_comp_1); % denominator

H = Y./X; % frequency response

h = ifft(H); % impulse response

figure('Name','Task 1.2: Impulse response vs correlation' ,'NumberTitle','off')
plot(tc, corr_result); hold on
plot(t,h)
grid on; xlabel('time [s]'); ylabel('amplitude [-]');
legend('correlation', 'impulse response')

figure('Name','Task 1.2: Impulse response vs correlation' ,'NumberTitle','off')
plot(tc, corr_result); hold on
plot(t,h)
grid on; xlabel('time [s]'); ylabel('amplitude [-]');
legend('correlation', 'impulse response')
xlim([-0.001,0.006]);
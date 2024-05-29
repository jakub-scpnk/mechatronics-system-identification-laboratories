% author: Jakub Szzczepaniak
% date: 28/05/2024

clear
clc

%% Task 2

fs = 1e4;
t = 0:1/fs:1;
y_mod = 0.5*chirp(t,50,t(end),200);
y_carr = sin(2*pi*t*1e3);
y = y_mod .* y_carr+y_carr;

figure
plot(t,y_mod)
hold on
plot(t,y_carr)
hold on
plot(t,y)
legend('y mod','y carry','y')
xlim([0,0.04])
xlabel('time [s]')
ylabel('amplitude [-]')
%% Task 2.1

% analitical signal;
ya = hilbert(y);

% envelope
ya_abs = abs(ya);

% figure
% plot(t,ya_abs)
% title('Envelope of modulated signal')
% xlabel('time [s]')
% ylabel('amplitude [-]')

% remove modulations
y_demod = y./abs(ya);

Y = fft(y);
N = length(Y);
fv = (0:N-1)*fs/N; % frequency vector

Y_demod = fft(y_demod);

figure
spectrum_dB(y, fs)
hold on
spectrum_dB(y_demod,fs)
grid on
xlim([0,5e3])
legend('y signal','with removed modulations')

%% Task 2

y_mod_2 = y.*y_carr;

% appying low pass filter
y_filt = lowpass(y_mod_2, 400, fs);

% removing constant componenet
y_filt = y_filt - mean(y_filt);

y_filt = 2*y_filt;

figure
spectrum_dB(y_mod,fs)
hold on
spectrum_dB(y_filt, fs)
xlim([1,400])
grid
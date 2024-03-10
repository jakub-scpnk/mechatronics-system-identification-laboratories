% Notation standard
fs = 500; % sampling frequency

% Creating a signal with given duration
%tend = 1;
%t = 0:(1/fs):tend;

% Creating a signal with given number of samples
N = 1000; % number of samples
t = (0:N-1)/fs; % time vector

A1 = 1; % amplitude
A2 = 2;
f1 = 30; % frequency
f2 = 30.5;

y = A1*sin(2*pi*f1*t) + A2*sin(2*pi*f2*t);

Y = fft(y);
N = length(Y);
df = fs/N; % frequency resolution
fv = (0:N-1)*fs/N; % frequency vector

figure()
plot(t,y)
xlabel('Time [s]');
ylabel('Amplitude');
grid on;

figure()
stem( fv , abs(Y)/length(y)*2)
xlim([0,(fs/2)]);
xlabel('Frequency [Hz]');
ylabel('Amplitude'); grid on;
save_fig2png(gcf,[16 9], 'lab_1_fig_1')
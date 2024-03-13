fs = 1000; % sampling frequency

% Creating a signal with given number of samples
N = 1000; % number of samples
t = (0:N-1)/fs; % time vector

% Amplitudes
A1 = 1;
A2 = 1;
% Frequencies
f1 = 125; % [Hz]
f2 = 375; % [Hz]

y = A1*sin(2*pi*f1*t) + A2*sin(2*pi*f2*t);

Y = fft(y);
N = length(Y);
df = fs/N; % frequency resolution
fv = (0:N-1)*fs/N; % frequency vector

figure(1)
plot(t,y);
xlabel('Time [s]');
ylabel('Amplitude [-]');
title('Signal y in time domain');

% Display the amplitude-frequency plot for the frequency range from 0 to
% the Nyquist frequency by scaling the Fourier transform amplitude
% accordingly.

figure(2)
stem( fv , abs(imag(Y)/length(y)*2));
xlim([0,(fs/2)]);
xlabel('Frequency [Hz]');
ylabel('Amplitude [-]');
title('Signal y in frequency domain');

% Then, subsample the signal, keeping every second sample from the original
% signal (y(1:2:end)). Calculate and display the fft result for the new
% signal by scaling the spectrum amplitude.

y = (y(1:2:end)); % We reduce sampling frequency by half

Y = fft(y);
N = length(Y);
df = fs/N; % frequency resolution
fv = (0:N-1)*fs/N; % frequency vector

figure(3)
stem( fv , abs(Y)/length(y)*2);
xlim([0,(fs/2)]);
xlabel('Frequency [Hz]');
ylabel('Amplitude [-]');
title('Subsampled signal y in frequency domain');
subtitle('sampling frequency was reduced by half')



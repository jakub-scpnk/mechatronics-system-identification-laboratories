%% First step

fs = 100; % sampling rate

% Creating a signal with given duration
tend = 1; % [s]
t = 0:(1/fs):tend; % time vector

% Amplitudes
A1 = 10;
A2 = 0.02;
% Frequencies
f1 = 7; % [Hz]
f2 = 20; % [Hz]

% Signal creation
y1 = A1*sin(2*pi*f1*t) + A2*sin(2*pi*f2*t);

% Calculating fft
Y = fft(y1);
N = length(Y);             % Calculating length of signal
Y_mag = abs(Y(1:N/2 + 1)); % Extracting magnitudes of positive component up
                           % to Nyquist frequency
df = fs/N;                 % Frequency resolution

fv = linspace(0, fs/2, N/2 + 1);  % Frequency vector (up to Nyquist freq)

% Convert magnitude to dB (log scale)
Y_fft_dB = 20 * log10(Y_mag);

% Plot the spectrum on a logarithmic scale
figure;
semilogx(fv, Y_fft_dB); % semilogx - x axis has a log scale
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
xlim([0,(fs/2)]);
grid on;
hold on;


%% Second step

y2 = y1 .* hann(length(y1))'; % Multiplying first signal by Hann window

% Calculating fft
Y2 = fft(y2);

Y2_mag = (Y2(1:N/2 + 1)); % Extracting magnitudes of positive component up
                          % to Nyquist frequency

% Convert magnitude to dB (log scale)
Y2_fft_dB = 20 * log10(Y2_mag);

semilogx(fv, Y2_fft_dB); % displaying second signal on the same graph
legend('y1', 'y2');


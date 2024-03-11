fs = 100; % sampling rate

% Creating a signal with given duration
tend = 1; % [s]
t = 0:(1/fs):tend;

A1 = 10;
A2 = 0.02;
f1 = 7; % [Hz]
f2 = 20; % [Hz]

y1 = A1*sin(2*pi*f1*t) + A2*sin(2*pi*f2*t);

Y = fft(y1);
N = length(Y);
df = fs/N;
fv = (0:N-1)*df/N;
fv = 20*log10(fv);

figure()
plot( fv , abs(Y)/(N/2))
yscale('log')
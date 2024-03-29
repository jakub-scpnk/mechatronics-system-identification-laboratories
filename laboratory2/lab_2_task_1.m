%% Filtration methods in MATLAB

fs = 1000; % [Hz]
N = 1000;  % samples

t = (0:N-1)/fs; % time vector

A1 = 1;
A2 = 0.2;
f1 = 10; %  [Hz]
f2 = 300; % [Hz]

y = A1*sin(2*pi*f1*t) + A2*sin(2*pi*f2*t);

L = 21; % The length of rectangular window
h = rectwin(L);
h = h/length(h);

%% Task 1.1

yc = conv(y,h);
yc = yc(1:N);

yf = filter(h, 1, y);

% Comparison in time domain:
figure()
plot(t,y); hold on;
plot(t,yc); hold on;
plot(t,yf,'o');
legend('y','yc','yf');
xlabel('time [s]');
ylabel('amplitude [-]');
title('Comparison of filtration methods in time domain');

figure()
freqz(h,1,length(h)*256,fs) % You can limit y to -60 dB in upper plot

%% Task 1.2

y_filtfilt = filtfilt(h,1,y); % the build-in implementation

x = filter(h,1,y);
x = x(end:-1:1);
x = filter(h,1,x);
x = x(end:-1:1);
x = x(1:N);

% x = conv(y,h);
% x = x(end:-1:1);
% x = conv(x,h);
% x = x(end:-1:1);
% x = x(1:N);

figure()
plot(t,y_filtfilt, 'o'); hold on;
plot(t,x);
xlabel('time [s]');
ylabel('amplitude [-]');
legend('filtfilt function', 'filter with time reversal');

% The problem with this approach is that it can be done only offline,
% artifically after the signal is collected

%% Task 1.3

h1 = rectwin(11);
h1 = h1/(length(h1));
h2 = rectwin(51);
h2 = h2/(length(h2));

figure()
freqz(h1,1,length(h1)*2,fs)

figure()
freqz(h2,1,length(h2)*2,fs)


%% Laboratory 3 Task 1
% date: 21/03/2024
% author: Jakub Szczepaniak

fs = 2000;      % sampling frequency [Hz]
N = 1000;       % number of samples [-]
t = (0:N-1)/fs; % time vector [s]

y = zeros(N,1); % empty signal vector

%% Task 1.1

f1 = 10;  % [Hz]
f2 = 300; % [Hz]

Np = 200;
tp = (0:Np-1)/fs; % chirp time vector [s]

yp = chirp(tp,f1,tp(end),f2); % chrirp variable frequency signal
yp = yp .* hann(1,length(yp));   % multiplying by Hann window

% correlation
y(500:500+length(yp)-1) = yp;
[yc,lag] = xcorr(y,yp);
tc = lag/fs; % time vector for lag signal

% amplitude normalization
max_abs_y = max(abs(y));
max_abs_yc = max(abs(yc));

y_norm = y / max_abs_y;
yc_norm = yc / max_abs_yc;

% convolution
y_conv = conv(y,yp);
t_conv = (0:length(y_conv)-1)/fs;

figure('Name','Task 1.1: Correlation' ,'NumberTitle','off')
plot(t,y_norm)
hold on
plot(tc,yc_norm)
grid on
xlabel('time [s]'); ylabel('normalized amplitude [-]');
legend('original signal', 'correlation','Location','northwest');
title('Result of correlation');

figure('Name','Task 1.1: Convolution' ,'NumberTitle','off')
plot(t,y)
hold on
plot(t_conv,y_conv)
grid on
xlabel('time [s]'); ylabel('amplitude [-]');
legend('original signal', 'convolution','Location','northwest');
title('Result of convolution');

%% Task 1.2

figure('Name','Task 1.2: Correlation' ,'NumberTitle','off')
colors = ["#0072BD","#D95319","#EDB120"];
i = 1;

Np = 200;
tp = (0:Np-1)/fs; % chirp time vector [s]

f1 = 30; % [Hz]

for f2 = [100, 200 500]
    yp = chirp(tp,f1,tp(end),f2); % chrirp variable frequency signal
    yp = yp .* hann(1,length(yp));   % multiplying by Hann window

    % correlation
    y(500:500+length(yp)-1) = yp;
    [yc,lag] = xcorr(y,yp);
    tc = lag/fs; % time vector for lag signal

    % amplitude normalization
    max_abs_y = max(abs(y));
    max_abs_yc = max(abs(yc));

    y_norm = y / max_abs_y;
    yc_norm = yc / max_abs_yc;

    % plotting
    p1 = plot(t,y_norm,':');
    hold on
    p1.Color = colors(i);
    p2 = plot(tc,yc_norm);
    hold on
    p2.Color = colors(i);

    i = i+1;
end

title('Correlation result using different chirp signals');
subtitle('narrowed up to the area of interest');
xlim([0.23,0.27]); % signal starts at 0.25 [s]
grid on
xlabel('time [s]')
ylabel('normalized amplitude [-]')
legend('f1 = 30, f2 = 100', 'corr result','f1 = 30, f2 = 200', ...
    'corr result', 'f1 = 30, f2 = 500', 'corr result', 'Location', ...
    'northwest');



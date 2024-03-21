%% Designing IIR and FIR filters

fs = 4000;       % samping frequency
tmax = 1-1/fs;   % time duration [s]
t = 0:1/fs:tmax; % time vector [s]

s = length(t);
f = linspace(0,fs-fs/s,s); % frequency vector

% central frequency of sine waves
w = [200,400,700,850];
% Hanning window with 200 samples
mask = hann(200);
% time delay of the signals
inds = [1400,1000,1200,800];

% memory allocation for signal y
y = zeros(length(t),1);

% buliding signal - sine waves addition
for i = 1:length(w)
    m = zeros(s,1);
    m(inds(i):inds(i)+length(mask)-1) = mask;
    y_temp = sin(2*pi*t*w(i)).*m.';
    y = y+y_temp.';
end

figure()
plot(t,y);
title('Signal y in time domain');
xlabel('time [s]');
ylabel('amplitude [-]');
grid on;

save_fig2png(gcf,[16 9], 'lab_2_task_2_fig_1');
% plotFFT(y,fs);

%% Task 2.1

load Hd1.mat % Loading prepared FIR filter
y1 = filter(Hd1.Numerator,1,y);

% The filtered signal is shifted by the length of the numerator of filter,
% so we need to account for that:
t1 = t-(length(Hd1.Numerator)/fs)/2;

figure()
plot(t,y);
title('Signal after filtering out the high frequency component');
xlabel('time [s]');
ylabel('amplitude [-]');
grid on;
hold on;

plot(t1,y1,'-.');
xlim([0,1]);
legend('original signal', 'signal after FIR filtration');
hold off;

save_fig2png(gcf,[16 9], 'lab_2_task_2_fig_2');

%% Task 2.2

load Hd2.mat % Loading prepared IIR filter
% Extract numerator and denominator coefficients
[Num, Den] = sos2tf(Hd2.sosMatrix, Hd2.ScaleValues);

% Apply zero-phase filtration using the extracted coefficients
y2 = filtfilt(Num, Den, y);

figure()
plot(t,y);
title('Signal after filtering out the high frequency component');
xlabel('time [s]');
ylabel('amplitude [-]');
grid on;
hold on;

plot(t,y2,'-.');
plot(t1,y1,'-.');
xlim([0,1]);
legend('original signal', 'signal after IIR filtration', ...
    'signal after FIR filtration');
hold off;

save_fig2png(gcf,[16 9], 'lab_2_task_2_fig_3');

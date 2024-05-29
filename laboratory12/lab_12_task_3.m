clear
clc

%% Task 3

fs = 2e5;
fc = 1e4;
t = 0:1/fs:1;
y_mod = sin(2*pi*t*500);
y_carr = sin(2*pi*t*fc);
y = sin(2*pi*t*fc+y_mod);

y_env = abs(hilbert(y));
%% Filter out noise

% data – data from file
% fs – sampling feequency
[data,fs] = audioread(['ktoto.wav']);

t = 0:1/fs:(353136 - 1)/fs;% time vector [s]

figure()
plot(t',data);
xlabel('time [s]');
xlim([0,length(t)/fs]);

% Num – numerator of FIR filter
%dataF(:,1) = filter(Num,1,squeeze(data(:,1)));
%dataF(:,2) = filter(Num,1,squeeze(data(:,2)));
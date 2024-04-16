% author: Jakub Szczepaniak
% date: 04.04.2024r

%% Task 2.1

figure('Name','Task 2.1: Autocorrelation' ,'NumberTitle','off')

for file = ["twomicrophones2/twospeakers1_ref.wav", ...
        "twomicrophones2/twospeakers1.wav", ...
        "twomicrophones2/twospeakers2.wav"]
    
    [audio, fs] = audioread(file);    % reading the file
    audio_comp = audio - mean(audio); % removing constant compoents

    [acorr_result, lag] = xcorr(audio_comp); % autocorrelation
    tc = lag/fs; % time vector for correlation result

    plot(tc, acorr_result)
    hold on
end

title('Autocorrelation of recordings')
xlabel('time [s]'); ylabel('amplitude [-]'); grid on;
legend('reference', 'recording 1', 'recording 2');
xlim([-0.008,0.008]); % limiting to area of interest

save_fig2png(gcf,[16 9], 'lab_4_task_1_fig_1');

%% Task 2.2

audio_1 = audioread("twomicrophones2/twospeakers1.wav");
[audio_2, fs] = audioread("twomicrophones2/twospeakers2.wav");

% aplication of lowpass filters
filtered_1 = lowpass(audio_1, 1000, fs);
filtered_2 = lowpass(audio_2, 300, fs);

figure('Name','Task 2.2: Filtered noise analysis' ,'NumberTitle','off')

for i = [filtered_1, filtered_2]
    i = i - mean(i);
    [acorr, lag] = xcorr(i);
    tc = lag/fs;
    plot(tc,acorr)
    hold on
end

title('Autocorrelation of filtered signals');
subtitle('Lowpass filter of 1000 Hz and 300 Hz for recordings 1 and 2 respectively');
legend('recording 1', 'recording 2'); xlabel('time [s]');
ylabel('amplitude [-]'); xlim([-0.01,0.01]); grid on;

save_fig2png(gcf,[16 9], 'lab_4_task_1_fig_2');

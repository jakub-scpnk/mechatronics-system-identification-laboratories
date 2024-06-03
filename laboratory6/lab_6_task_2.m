% run task 1 and dont clear the workspace after

%% Task 2
load('dane-pomiarowe/20220401-RLC_Chirp1v300kHz_T2s.mat')

df = 1; 
window = round(fs/df); 
overlap = round(window/2); 
nfft = window; 
[H1,F] = tfestimate(B,A,window,overlap,nfft,fs,'twosided'); 

% Plot of the estimated transfer function (H1) against frequency (F) 
figure
plot(F, abs(H1), 'LineWidth', 2)
title('Estimated Transfer Function')
subtitle('using tfestimate function')
xlabel('frequency [Hz]')
ylabel('magnitude [-]')
xlim([1e3,3e5])
grid on

saveas(gcf,['figures/lab_6_task_2_fig_1.png'])

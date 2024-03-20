function out = plotFFT(y,fs)
    % Function plots signal in frequency domain using FFT.

    Y = fft(y);
    N = length(Y);
    % df = fs/N; % frequency resolution
    fv = (0:N-1)*fs/N; % frequency vector

    plot( fv , abs(imag(Y)/length(y)*2));
    xlim([0,(fs/2)]);
    xlabel('Frequency [Hz]');
    ylabel('Amplitude [-]');
    title('Signal in frequency domain');
end
function [] = spectrum_dB(signal,fs)
    % this function plots spectrum of 1-D time series
    % signal - input signal
    % fs - sampling frequency

    Y = fft(signal); % fourier transform
    N = length(Y);
    fv = (0:N-1)*fs/N; % frequency vector

    plot(fv,20*log10(abs(Y)/N))
    xlim([0,fs/2])
    xlabel('frequency [Hz]')
    ylabel('amplitude [dB]')
    grid

end
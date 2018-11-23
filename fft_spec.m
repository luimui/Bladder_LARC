function [f xFFT] = fft_spec(xx,fs)     

xFFT = fft(xx);
xFFT = abs(xFFT); %eliminate imaginary part
N = fix((length(xFFT)/2)+1); %half the spectrum
xFFT = xFFT(1:N);
xFFT = xFFT*(2/N); %physical unit of magnitude

f = linspace(0, fs/2, N);

end

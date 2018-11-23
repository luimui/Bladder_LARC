Fs = 10;
t = 0:1/Fs:length(y)/Fs-1/Fs;

z = hilbert(y);
instfreq = Fs/(2*pi)*diff(unwrap(angle(z)));

plot(t(2:end),instfreq)
xlabel('Time')
ylabel('Hz')
grid on
title('Instantaneous Frequency')
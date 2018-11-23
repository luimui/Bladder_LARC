fs=10;
lev = 4;
wname = 'sym8';
figure
for i = 1:(size(a.rawforfft,2));
sig = a.raw(:,i);
[dnsig1,c1,threshold_SURE] = wden(sig,'rigrsure','h','mln',lev,wname);
[dnsig2,c2,threshold_Minimax] = wden(sig,'minimaxi','h','mln',lev,wname);
[dnsig3,c3,threshold_DJ] = wden(sig,'sqtwolog','h','mln',lev,wname);

xx = dnsig3;

% subplot((size(a.rawforfft,2)),1,i)
% plot(xx)
% %title(i)
% %xlim([0.01 1])
% %ylim([-0.1 0.1])

  
 xx = hann(length(xx)).*xx;
 xFFT = pwelch(xx);
 xFFT = abs(xFFT); %eliminate imaginary part
 N = fix((length(xFFT)/2)+1); %half the spectrum
 xFFT = xFFT(1:N);
 xFFT = xFFT*(2/N); %physical unit of magnitude
 
 f = linspace(0, fs/2, N);
 
 f = f(7:end);
 xFFT = xFFT(7:end);
 
%xFFT = movmean(xFFT,5);
 
subplot((size(a.rawforfft,2)),1,i)
plot(f,xFFT)
title(i)
xlim([0.01 1])
%ylim([0 0.01])


k = 1;
[val ind] = sort(xFFT,'descend');

maxi_f_BL(i) = mean([f(ind(1:k))]);
maxi_amp_BL(i) = mean([xFFT(ind(1:k))]);
end



 
 

%DOI: 10.1109/ICECTE.2016.7879617
%A new machine learning approach to select adaptive IMFs of EMD




sig = data{13,10}{1,1};


imf = eemd(sig,2,5);

%Pwelch Variables
window = 600;
overlap = 300;
DFT_points = 600;


% [imf its]=ceemdan(sig,0.2,500,5000);
% imf = imf';

Pi=zeros(size(imf,2)-1,1);
for i = 2:size(imf,2)
    Pi(i-1)=corr(sig,imf(:,i),'Type','Pearson');
end

%Apply Threshold
T = max(Pi)/(10*max(Pi)-3);

for i = 1:size(Pi)
    if Pi(i,1) >= T
        Pi(i,2) = 1;
    else Pi(i,2) = 0;
    end
end

[idx,v]=find(Pi(:,2)==1);
imf_threshold = zeros(size(imf,1),size(idx,1));

for i = 1:size(idx,1)
    imf_threshold(:,i) = imf(:,idx(i));
end

max_f=zeros(size(imf_threshold,2),1);
max_amp=zeros(size(imf_threshold,2),1);
figure
for ii = 1:size(imf_threshold,2)
    [pxx,f] = pwelch(imf_threshold(:,ii),window,overlap,DFT_points,10);
    [val,index] = max(pxx);
    max_f(ii) = f(index);
    max_amp(ii) = pxx(index);  
end

pxx=zeros(size(pwelch(imf_threshold(:,1),window,overlap,DFT_points,10),1),size(imf_threshold,2));
for ii = 1:size(idx,1)
    [pxx(:,ii),f] = pwelch(imf_threshold(:,ii),window,overlap,DFT_points,10);
%     f = (1./f')';
    subplot(size(idx,1)+1,1,ii+1)
    plot(f,pxx(:,ii))
    xlim([0 1])
    ylim([0 max(max_amp)])
    
end
 subplot(size(idx,1)+1,1,1) 
 plot(imf(:,1))

curve=zeros(size(pxx,1),1);
for i = 1:size(pxx,2)
curve = curve + pxx(:,i);
end
figure
plot(curve)
xlim([0 60])

% figure
% for i = 1:size(imf,2)
%     subplot(size(imf,2),1,i)
%     plot(imf(:,i))
%     xlim([0 6000])
% end
% 
% 
% 
% figure
% for i = 1:size(idx,1)
%     subplot(size(idx,1)+1,1,i+1)
%     plot(imf(:,idx(i)))
%     xlim([0 6000])
%     ylim([min(min(imf_threshold)) max(max(imf_threshold))])
% end
% subplot(size(idx,1)+1,1,1)
% plot(imf(:,1))
% xlim([0 6000])

    
    
    
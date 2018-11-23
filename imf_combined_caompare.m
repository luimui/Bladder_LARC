close all


data = data_table(ismember(data_table.Pharmaca,'DMSO') | ismember(data_table.Pharmaca,'DMSO ZD'),:);

imf_combined_psd_curve  = cell(size(data,1),1);
data = [data table(imf_combined_psd_curve)];

%Pwelch Variables
window = 600;
overlap = 300;
DFT_points = 600;



individual_list = unique(data.Individual);

for i_table = 1:size(individual_list,1)
    
    figure
    for ii_table = 1:size(data{ismember(data.Individual,individual_list{i_table,1}),'Detrended_Data'},1)
        
        sig = data{ismember(data.Individual,individual_list{i_table,1}),'Detrended_Data'}{ii_table};
        imf = eemd(sig,2,5);

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
        
        %Find Max_amp and max_f and plot
        max_f=zeros(size(imf_threshold,2),1);
        max_amp=zeros(size(imf_threshold,2),1);
%         figure
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
%             subplot(size(idx,1)+1,1,ii+1)
%             plot(f,pxx(:,ii))
%             xlim([0 1])
%             ylim([0 max(max_amp)])

        end
%          subplot(size(idx,1)+1,1,1) 
%          plot(imf(:,1))

        curve=zeros(size(pxx,1),1);
        for i = 1:size(pxx,2)
        curve = curve + pxx(:,i);
        end
        
        data{ismember(data.Individual,individual_list{i_table,1}),'imf_combined_psd_curve'}(ii_table) = {curve};
        
        plot(curve,'DisplayName',data{ismember(data.Individual,individual_list{i_table,1}),'Pharmaca'}{ii_table})
        title(individual_list{i_table,1})
        xlim([0 60])
        legend
        hold on
    end
end

max_list = zeros(size(individual_list,1),size(data{ismember(data.Individual,individual_list{i_table,1}),'Detrended_Data'},1));
for i_table = 1:size(individual_list,1)
    for ii_table = 1:size(data{ismember(data.Individual,individual_list{i_table,1}),'Detrended_Data'},1)
       max_list(i_table,ii_table) = max(data{ismember(data.Individual,individual_list{i_table,1}),'imf_combined_psd_curve'}{ii_table});
    end
end

       
       
       
       
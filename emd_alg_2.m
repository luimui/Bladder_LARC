
data = data_table;

    %Perform EMD
    imfs = 3
    
    emd_imf = cell(size(data,1),imfs);
    pwelch_max_f  = cell(size(data,1),1);
    pwelch_max_amp  = cell(size(data,1),1);
    rel_pwelch_max_amp  = cell(size(data,1),1);
    
    data = [data table(emd_imf)];
    data = [data table(pwelch_max_f)];
    data = [data table(pwelch_max_amp)];
    data = [data table(rel_pwelch_max_amp)];
    
    
    for i = 1:length(data{:,1})

        imf = emd(data{i,10}{1,1});
    
        %PweclhSpectrum of IMFs  
        max_f = zeros(imfs,1);
        max_amp = zeros(imfs,1);
        
        for ii = 1:imfs
            [pxx,f] = pwelch(imf(:,ii),[],[],[],10);
            %find Max_Peaks of IMFs
            [v,index] = max(pxx);
            max_f(ii) = f(index);
            max_amp(ii) = pxx(index);
            
        end
      
      rel_max_amp = {max_amp/sum(max_amp)}  
      
      data(i,'emd_imf') =  {imf};
      data(i,'pwelch_max_f') =  {max_f};
      data(i,'pwelch_max_amp') =  {max_amp};
      data(i,'rel_pwelch_max_amp') =  {rel_max_amp};
      
    end
    
    


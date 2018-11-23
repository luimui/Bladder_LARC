%Noise entfernen 

cells = cell(0,1);
headers = {'Denoised_Data'};
denoised_column = cell2table(cells);
denoised_column.Properties.VariableNames = headers;

for n = 1:height(data_table)

    
    fs=10;
    lev = 4;
    wname = 'sym8';

    sig = data_table.Detrended_Data{n,1};
    [dnsig1,c1,threshold_SURE] = wden(sig,'rigrsure','h','mln',lev,wname);
    [dnsig2,c2,threshold_Minimax] = wden(sig,'minimaxi','h','mln',lev,wname);
    [dnsig3,c3,threshold_DJ] = wden(sig,'sqtwolog','h','mln',lev,wname);

    xx = dnsig3;
    
    denoised_column.Denoised_Data{n,1} = [];
    denoised_column.Denoised_Data{n,1} = xx;
    
end

data_table = [data_table denoised_column]




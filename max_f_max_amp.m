%find main frequency and maximum amplitude

cells = cell(0,2);
headers = {'Max_f','Max_Amp'};
max_column = cell2table(cells);
max_column.Properties.VariableNames = headers;

for n = 1:height(data_table)

    f = data_table.FFT_Data{n,1};
    xFFT = data_table.FFT_Data{n,2};
    
    
    k = 1;
    [val ind] = sort(xFFT,'descend');

    maxi_f = mean([f(ind(1:k))]);
    maxi_amp = mean([xFFT(ind(1:k))]);

    max_column.Max_f(n,1) = maxi_f;
    max_column.Max_Amp(n,1)= maxi_amp;
    
end

data_table = [data_table max_column]



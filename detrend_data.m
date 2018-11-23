%nichtlinearen trend entfernen detrend

cells = cell(0,1);
headers = {'Detrended_Data'};
detrend_colum = cell2table(cells);
detrend_colum.Properties.VariableNames = headers;

for n = 1:height(data_table)

    x1 = data_table.Normalized_Raw_Data{n,1};
    
    opol = 6;
    [p,s,mu] = polyfit((1:size(x1))',x1,opol);
    f_y = polyval(p,(1:size(x1))',[],mu);

    x1 = x1 - f_y;
    
    detrend_colum.Detrended_Data{n,1} = [];
    detrend_colum.Detrended_Data{n,1} = x1;
    
end

data_table = [data_table detrend_colum]
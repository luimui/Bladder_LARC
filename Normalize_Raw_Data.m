cells = cell(0,1);
headers = {'Normalized_Raw_Data'};
normalize_column = cell2table(cells);
normalize_column.Properties.VariableNames = headers;

for n = 1:height(data_table)
    normalize_column.Normalized_Raw_Data{n,1} = [];
    normalize_column.Normalized_Raw_Data{n,1:end} = data_table.Raw_Data{n,1:end}/data_table.KCl_Response(n);
     
end

a=0
for n = 1:height(data_table)
if find(data_table.Raw_Data{n,1}<0)>0 
    a=a+1
end
end

data_table = [data_table normalize_column]
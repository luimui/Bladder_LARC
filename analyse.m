data1 = data_table(ismember(data_table.Pharmaca,'DMSO'),:);
data2 = data_table(ismember(data_table.Pharmaca,'DMSO ZD'),:);
imfs=3
for i = 1:size(data1,1)
    figure
    plot(data1{i,16}{1},data1{i,17}{1})
%     xlim([0 0.6])
    hold on
    plot(data2{i,16}{1},data2{i,17}{1})
%     set(gca, 'XScale', 'log')
    title(string(data2{i,3}))
end

for i = 1:size(data1,1)
    [max_f,y]=max(data1{i,16}{1})
    max_amp=data1{i,18}{1}(y)
end




% for i = 1:size(data,1)
%     plot(data{i,16}{1},data{i,18}{1});
% end
% set(gca, 'XScale', 'log')

% dataset = zeros(size(data,1),imfs*2)
% for i=1:size(data,1)
% 
%     for ii=1:imfs
% 
%         dataset(i,ii) = data{i,16}{1}(ii);
%         dataset(i,ii+imfs) = data{i,18}{1}(ii);
%     end
%     
% end
%    
% figure
% plotmatrix(dataset(:,1:3),dataset(:,4:6))
pharma = unique(data_table.Pharmaca)

imfs = 6;
max_f_list = cell(length(pharma),imfs);
max_f_list(:,1) = pharma;
max_amp_list = cell(length(pharma),imfs);
max_amp_list(:,1) = pharma;

for idx = 1:length(pharma)
    %Choose Data
    data = data_table(ismember(data_table.Pharmaca,pharma(idx)),:);

    %Perform EMD
    imf_list = cell(length(data{:,1}),2);
    for i = 1:length(data{:,1})

        imf = emd_hht(data{i,10}{1,1});
        imf = vertcat(imf{:});
        imf_list{i,1} = data{i,5};
        imf_list{i,2} = imf;

    end

    %Perform Welch Specogram

    for i = 1:length(data{:,1})
        for ii = 1:imfs
            [pxx,f] = pwelch((imf_list{i,2}(ii,:)),[],[],[],10);
            [v,index] = max(pxx);
            max_f = f(index);
            max_amp = pxx(index);
            imf_list{i,ii+2} = [max_f, max_amp];
            
        end
    end

    for i = 3:size(imf_list,2)
        max_f_list(idx,i-1) = {cell2mat(imf_list(:,i))};
    end
    
    group_rel_amp_cells = cell(size(max_f_list,1),size(max_f_list,2));
    %Relative Pwelch Spec Power
    for i = 1:size(max_f_list,1)
        
        group_max = [cell2mat({cell2mat(max_f_list(i,2:end))})];
        group_rel_amp = zeros(size(group_max,1),size(group_max,2)/2);
        
        for ii = 1:size(group_max,1)
%             [max_f_list{i,(ii/2)+1}, zeros(size(max_f_list{i,(ii/2)+1},1),1)]
            for iii = 2:2:(size(group_max,2))
                group_rel_amp(ii,iii/2) = group_max(ii,iii)/sum(group_max(ii,2:2:end));
%                 max_f_list{i,(ii/2)+1} = group_max(ii,iii)/sum(group_max(ii,2:2:end))
            end

        end
        for idx = 1:size(group_rel_amp,2)
            group_rel_amp_cells{i,idx+1}=[max_f_list{i,idx+1},group_rel_amp(:,idx)];
        end
        

    
        
    end
            
for idx = 1:size(group_rel_amp_cells,1)
    max_f_list(idx,2:end)=group_rel_amp_cells(idx,2:end);
end        
    
    
    
%     mean_imf = zeros(1,length(imf_list(1,3:end)));
%     std_imf = zeros(1,length(imf_list(1,3:end)));
%     for i = 3:size(imf_list,2)
% 
%         mean_imf(i-2) = mean(cell2mat(imf_list(:,i)));
%         std_imf(i-2) = std(cell2mat(imf_list(:,i)));
%     end


end

max_f_list_mean = cell(length(pharma),imfs);
max_f_list_mean(:,1) = pharma; 

max_f_list_std = cell(length(pharma),imfs);
max_f_list_std(:,1) = pharma;


max_amp_list_mean = cell(length(pharma),imfs);
max_amp_list_mean(:,1) = pharma; 

max_amp_list_std = cell(length(pharma),imfs);
max_amp_list_std(:,1) = pharma;

max_relamp_list_std = cell(length(pharma),imfs);
max_relamp_list_std(:,1) = pharma;
for i = 1:size(max_f_list_mean,1)
    for ii = 2:size(max_f_list_mean,2)
      
    max_f_list_mean{i,ii} = mean(max_f_list{i,ii}(:,1));
    max_f_list_std{i,ii} = std(max_f_list{i,ii}(:,1));
    
    max_amp_list_mean{i,ii} = mean(max_f_list{i,ii}(:,2));
    max_amp_list_std{i,ii} = std(max_f_list{i,ii}(:,2));
    
    max_relamp_list_mean{i,ii} = median(max_f_list{i,ii}(:,3));
    max_relamp_list_std{i,ii} = mad(max_f_list{i,ii}(:,3));
    end
end



x=2
y=4

bar_input=[cell2mat(max_relamp_list_mean(x,2:end));cell2mat(max_relamp_list_mean(y,2:end))];
error_input=[cell2mat(max_relamp_list_std(x,2:end));cell2mat(max_relamp_list_std(y,2:end))];

%errorbar_groups(bar_input,error_input)
barwitherr(error_input', bar_input')

xticklabels(max_f_list_mean(2,2:end))
% legend({max_amp_list_mean(x,1),max_amp_list_mean(y,1)})

  % for i = 1:length(data{:,1})
    %     
    %      figure
    %      for plotID = 1:imfs
    %         
    %         subplot(imfs, 1, plotID) ;
    %         plot(imf_list{i,2}(plotID,:)) ;
    %         title(string(imf_list{i,1})+' imf'+string(plotID))
    %      end
    % end

BL=cell(1,7)    
for i = 2:size(BL,2)
BL{i}=max_f_list{1,i}(1:12,:)
end

DMSO=cell(1,7)
for i = 2:size(DMSO,2)
DMSO{i}=max_f_list{2,i}(:,:)
end

BL_DMSO=cell(1,6)
for i = 2:size(DMSO,2)
BL_DMSO{i-1}=BL{1,i}(:,3)-DMSO{1,i}(:,:)
end

bar_input=zeros(1,6)
error_input=(zeros(1,6))

for i=1:6
bar_input(i)=mean(BL_DMSO{1,i}(:,3))
error_input(i)=std(BL_DMSO{1,i}(:,3))
end

figure
barwitherr(error_input', bar_input')



BL=cell(1,7)    
for i = 2:size(BL,2)
BL{i}=max_f_list{1,i}(13:25,:)
end

LTG100=cell(1,7)
for i = 2:size(LTG100,2)
LTG100{i}=max_f_list{4,i}(:,:)
end
BL_LTG100=cell(1,6)
for i = 2:size(DMSO,2)
BL_LTG100{i-1}=BL{1,i}(:,3)-LTG100{1,i}(:,:)
end

bar_input=zeros(1,6)
error_input=(zeros(1,6))

for i=1:6
bar_input(i)=mean(BL_LTG100{1,i}(:,3))
error_input(i)=std(BL_LTG100{1,i}(:,3))
end

figure
barwitherr(error_input', bar_input')




BL=cell(1,7)    
for i = 2:size(BL,2)
BL{i}=max_f_list{1,i}(26:37,:)
end
LTG300=cell(1,7)
for i = 2:size(LTG300,2)
LTG300{i}=max_f_list{6,i}(:,:)
end
BL_LTG300=cell(1,6)
for i = 2:size(DMSO,2)
BL_LTG300{i-1}=BL{1,i}(:,:)-LTG300{1,i}(:,:)
end

bar_input=zeros(1,6)
error_input=(zeros(1,6))

for i=1:6
bar_input(i)=mean(BL_LTG300{1,i}(:,3))
error_input(i)=std(BL_LTG300{1,i}(:,3))
end

figure
barwitherr(error_input', bar_input')






BL=cell(1,7)    
for i = 2:size(BL,2)
BL{i}=max_f_list{1,i}(38:48,:)
end
LTG500=cell(1,7)
for i = 2:size(LTG500,2)
LTG500{i}=max_f_list{8,i}(:,:)
end
BL_LTG500=cell(1,6)
for i = 2:size(DMSO,2)
BL_LTG500{i-1}=BL{1,i}(:,:)-LTG500{1,i}(:,:)
end

bar_input=zeros(1,6)
error_input=(zeros(1,6))

for i=1:6
bar_input(i)=mean(BL_LTG500{1,i}(:,3))
error_input(i)=std(BL_LTG500{1,i}(:,3))
end

figure
barwitherr(error_input', bar_input')



figure
for i=1:6
animal(i)=BL{i+1}(11,3)
end
plot(animal)
hold on
for i=1:6
animal(i)=LTG500{i+1}(11,3)
end
plot(animal)
    
    

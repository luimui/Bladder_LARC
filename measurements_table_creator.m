


%Datei Laden
     clear all;
     
    addpath('R:\Personal\Promotion\Organdbad\FFTProgram\Labchartexports','-end');
    addpath('R:\Personal\Promotion\Organdbad\FFTProgram');

    

    files = dir('*.mat');
    file_list={files.name}';
    uiwait(msgbox('Please choose a file, not matter wich one'));
    [fname, fpath]=uigetfile;
    load(fullfile(fpath,fname));
    
    
    %Transponieren für Octave
      x2=data';
      x2=x2*1000;
      dataseconds = (length(x2))/samplerate;
          
      %Comments von Labchart.m/comments.m holen
      comtickpos = com(:,3);
      comtextmap = com(:,5);

      %Comments als Cellarray anlegen
      comtickpos=comtickpos;
      commcells=cellstr(comtext(comtextmap,:));
      commentsforstring=[num2cell((comtickpos'));commcells'];
      commentsforstring=cellfun(@num2str,commentsforstring,'UniformOutput',0);
      disp(commentsforstring);
      
      
      uiwait(msgbox('Please choose Region of Data to normalize against'));
        [s,v]=listdlg('ListString',commentsforstring(2,:),'Name','Normalisierung');
        
        c=commentsforstring(2,s);
      
      %Zeitrahmen auswählen
          hms = fix(mod(dataseconds, [0, 3600, 60]) ./ [3600, 60, 1]);
          prompt={'Start in Sekunden vor / nach dem Marker','Stop in Sekunden vor / nach dem Marker','sample rate in Hz','Fenstergröße in Sekunden','Overlap in Sekunden'};
          title='Normalisierung';
          defaults={'0','180','10','60','30'};


          answer=inputdlg(prompt,title,1,defaults);


          startgap=str2num(answer{1});
          stopgap=str2num(answer{2});
          fs=str2num(answer{3});
          L=str2num(answer{4});
          overlap=str2num(answer{5});
    
          startgap=startgap*samplerate;
          stopgap=stopgap*samplerate;
        
          
          
          result_peak = zeros(1, length(files));
          for n = 1:length(files);    %length(files)
                           
              load(files(n).name);
              
              % Do some stuff
                %Transponieren für Octave
                x2=data';
                dataseconds = (length(x2))/samplerate;
                
                %Minimum der Messung 0 setzen
%                 x2=x2-min(x2);
                    
                
                %Comments von Labchart.m/comments.m holen
                  comtickpos = com(:,3);
                  comtextmap = com(:,5);

                  %Comments als Cellarray anlegen
                    comtickpos=comtickpos;
                    commcells=cellstr(comtext(comtextmap,:));
                    commentsforstring=[num2cell((comtickpos'));commcells'];
                    commentsforstring=cellfun(@num2str,commentsforstring,'UniformOutput',0);
                    
                  
                 %Commentposition suchen
                   [row,column]=find(strcmp(commentsforstring,c));
                   start=(str2double(commentsforstring(1,column)))+startgap;
                   stop=(str2double(commentsforstring(1,column)))+stopgap;
                   x1=x2(start:stop);
                   x1=x1(1:(fix(samplerate/fs)):length(x1)); %auf fs downsamplen
                   x=x1;
                  
                   
                 %Höchste Kontraktion suchen
                   result_peak(1,n)=max(x)-min(x);
                   result_max(1,n)=max(x);
                
              
                 
          end
    
    
    
    %Alle berechneten Variablen löschen, ausser result_peak, und dem
    %geladenen Labchartexport
    clearvars -except tone result_max result_peak folder_name files file_list fname fpath blocktimes com comtext data dataend datastart firstsampleoffset rangemax rangemin samplerate tickrate titles unittext unittextmap ZD1200 ZD1800 ZD600 nachZD
    
    
    
     
    %% 
    
    
    
      %Transponieren für Octave
      x2=data';
      dataseconds = (length(x2))/samplerate;
          
      %Comments von Labchart.m/comments.m holen
      comtickpos = com(:,3);
      comtextmap = com(:,5);

      %Comments als Cellarray anlegen
      commcells=cellstr(comtext(comtextmap,:));
      commentsforstring=[num2cell((comtickpos'));commcells'];
      commentsforstring=cellfun(@num2str,commentsforstring,'UniformOutput',0);
      disp(commentsforstring);
      
      uiwait(msgbox('Please choose region of data to transform')); 
      [s,v]=listdlg('ListString',commentsforstring(2,:));
        c=commentsforstring(2,s);
      
      %Zeitrahmen auswählen
          hms = fix(mod(dataseconds, [0, 3600, 60]) ./ [3600, 60, 1]);
          prompt={'Start in Sekunden vor / nach dem Marker','Stop in Sekunden vor / nach dem Marker','sample rate in Hz','Fenstergröße in Sekunden','Overlap in Sekunden','Pharma_comment','Species'};
          title='Kurvenschar Ausschnitt-FFT nach Sigmaplot';
          defaults={'-600','0','10','60','30',c{1},'Rat'};


          answer=inputdlg(prompt,title,1,defaults);


          startgap=str2num(answer{1});
          stopgap=str2num(answer{2});
          fs=str2num(answer{3});
          L=str2num(answer{4});
          overlap=str2num(answer{5});
    
          startgap=startgap*samplerate;
          stopgap=stopgap*samplerate;
        
          cells = cell(0,8);
          headers = {'ID','Species','Age','Individual','Pharmaca','Raw_Data','KCl_Response','Unit'};
          data_table = cell2table(cells);
          data_table.Properties.VariableNames = headers;
          
          for n = 1:length(files); %length(files)
                           
              load(files(n).name);
              
              id = dicomuid;
              species = answer{7};
              age = files(n).name;
              age = strsplit(age,'d');
              age = str2num(age{1});
              individual = files(n).name;
              kcl_response = result_peak(1,n);
              unit = unittext;
               
              pharma_comment = answer{6};
              
              
              % Do some stuff
                %Transponieren für Octave
                x2=data';
                dataseconds = (length(x2))/samplerate;
                
                %Comments von Labchart.m/comments.m holen
                  comtickpos = com(:,3);
                  comtextmap = com(:,5);

                  %Comments als Cellarray anlegen
                    commcells=cellstr(comtext(comtextmap,:));
                    commentsforstring=[num2cell((comtickpos'));commcells'];
                    commentsforstring=cellfun(@num2str,commentsforstring,'UniformOutput',0);
                    
                  
                 %Commentposition suchen
                   [row,column]=find(strcmp(commentsforstring,c));
                   start=(str2double(commentsforstring(1,column)))+startgap;
                   stop=(str2double(commentsforstring(1,column)))+stopgap;
                   x1=x2(start:stop);
                   x1=x1(1:(fix(samplerate/fs)):length(x1)); %auf fs downsamplen
                   x=x1;
                  
                 %Rohwerte x abspeichern
                 raw=x1;
                 
                 new_table_row = {id, species, age, individual, pharma_comment, raw, kcl_response, unit};
                 data_table = [data_table;new_table_row];
     
          end

          
%Daten zur Datei addieren 
    data_table_new = data_table;
    clear data_table
    uiwait(msgbox('Please choose to add data_table to'));
    [fname, fpath]=uigetfile;
    load(fullfile(fpath,fname));
    data_table = [data_table;data_table_new];
   
%Daten speichern
   cd(fpath)
   uisave({'data_table'},(fname))
  
   
   
   
   
   
   
   
   
   
   
   
   
   
   
  
   
   
 
 
 
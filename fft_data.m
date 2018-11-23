%FFT erstellen 

cells = cell(0,1);
headers = {'FFT_Data'};
FFT_column = cell2table(cells);
FFT_column.Properties.VariableNames = headers;

for n = 1:height(data_table)

    xx = data_table.Denoised_Data{n,1};
    
    xx = hann(length(xx)).*xx;
    xFFT = fft(xx);
    xFFT = abs(xFFT); %eliminate imaginary part
    N = fix((length(xFFT)/2)+1); %half the spectrum
    xFFT = xFFT(1:N);
    xFFT = xFFT*(2/N); %physical unit of magnitude

    f = linspace(0, fs/2, N);

    f = f(7:end);
    f = f';
    xFFT = xFFT(7:end);

    FFT_column.FFT_Data{n,1} = [];
    FFT_column.FFT_Data{n,1} = f;
    FFT_column.FFT_Data{n,2} = xFFT;
    
end

data_table = [data_table FFT_column]

function y = preproc(x,Fe_x,Fe,Ft)
x_mono = (x(:,1)+x(:,2))/2; %conversie stereo-mono

%schimbarea frecventei de esantionare
[p,q] = rat(Fe/Fe_x);
x_mono = resample(x_mono,p,q);

%normalizarea amplitudinii in intervalul [-1;1]
x_max = max(abs(x_mono));
x_norm = (1/x_max)*x_mono;

%proiectarea FTS folosind functia fir1
fn = Fe/2;
b = fir1(20,Ft/fn,'high');
y = filter(b,1,x_norm);
end
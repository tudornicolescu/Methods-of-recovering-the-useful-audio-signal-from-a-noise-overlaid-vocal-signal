function y = preproc2(x,Fe_x,Fe)
%schimbarea frecventei de esantionare
[p,q] = rat(Fe/Fe_x);
x = resample(x,p,q);

%normalizarea amplitudinii in intervalul [-1;1]
x_max = max(abs(x));
y = (1/x_max)*x;
end
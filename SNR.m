function R = SNR(s, n)
%se calculeaza puterile celor doua semnale
Ps = mean(s.^2);
Pn = mean(n.^2);
%se calculeaza SNR-ul ca R=10*lg(Ps/Pn)
R = 10*log10(Ps/Pn);
end
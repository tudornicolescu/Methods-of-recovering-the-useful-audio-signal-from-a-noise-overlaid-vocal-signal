close all
clear all
clc

%citirea celor trei fisiere audio utilizate in program
[ss,Fe_ss] = audioread('sample.wav');
[ms,Fe_ms] = audioread('magpie_sample.wav');
[tm,Fe_tm] = audioread('tywin_magpie.wav');

%setarea frecventei de esantionare Fe la 16kHz si frecventa de taiere a
%filtrului trece-sus la 80Hz, frecvente utilizate in apelarea functiilor de
%proprocesare
Fe = 16000;
Ft = 80;
xs = preproc(ss,Fe_ss,Fe,Ft);
xm = preproc2(ms,Fe_ms,Fe);
xtm = preproc2(tm,Fe_tm,Fe);
plot((1:length(xs)),xs)
title('Inregistrarea audio facuta de student')
figure
plot((1:length(xm)),xm)
title('Sunetul de pasare suprapus peste semnalele utile')
figure
plot((1:length(xtm)),xtm)
title('Inregistrarea GoT cu sunetul de pasare suprapus')

%se seteaza factorul de mixaj la 50% si se suprapun aditiv inregistrarea
%facuta de student cu sunetul de pasare
m_mix = 0.5;
xsm = smMix(xs,xm,m_mix);
figure
plot((1:length(xsm)),xsm)
title('Inregistrarea facuta de student mixata cu sunetul de pasare')

%se calculeaza SNR-urile pentru semnalul util xs si semnalul xsm
%(xs + sunetul de pasare)
SNR_sm = SNR(xsm(31008:38430),xsm(26323:30166));
SNR_s = SNR(xs(31008:38430),xs(26323:30166));

%in sectiunea urmatoare s-a cautat ordinul optim al filtrului Wiener prin
%compararea SNR-urilor rezultate
%Snr_optim = [];
%for i = 1:60
%   [xs_inv,hw] = wienerFilt(xsm,xs,i);
%   Snr_optim(i) = SNR(xs_inv(31008:38430),xs_inv(26323:30166));
%end

%dupa gasirea ordinului optim, se trece semnalul xsm prin filtrul rezultat
%si se genereaza SNR-ul rezultatului xs_inv
[xs_inv,hw] = wienerFilt(xsm,xs,31);
SNR_sinv = SNR(xs_inv(31008:38430),xs_inv(26323:30166));
figure
plot((1:length(xs_inv)),xs_inv)
title('Semnalul de la iesirea filtrului Wiener cand la intrare este inregistrarea facuta de student mixata cu sunetul de pasare')

%se calculeaza SNR-ul semnalului xtm, semnalul se trece prin filtrul Wiener
%proiectat si se calculeaza SNR-ul semnalului obtinut
SNR_tm = SNR(xtm(16733:20457), xtm(1:15116));
xt_inv = filterW(xtm, hw);
SNR_tinv = SNR(xt_inv(16733:20457), xt_inv(1:15116));
figure
plot((1:length(xt_inv)),xt_inv)
title('Semnalul de la iesirea filtrului Wiener cand la intrare este inregistrarea GoT cu sunetul de pasare suprapus')

%in secventa urmatoare s-a cautat parametrul L optim pentru functia
%adaLineEnh, mu si alpha s-au ales prin incercari
%Snr_test = [];
%i = 1;
% for L = 1:100
%     xt_ALE = adaLineEnh(xtm,35,0.001,0.15,mean(xtm.^2),L);
%     SNR_test(i) = SNR(xt_ALE(16733:20457), xt_ALE(1:15116));
%     i = i+1;
% end

%folosind nLMS se incearca eliminarea sunetului de pasare din semnalul xtm
xt_ALE = adaLineEnh(xtm,35,0.00001,0.5,mean(xtm.^2),60);
SNR_tale = SNR(xt_ALE(16733:20457), xt_ALE(1:15116));
figure
plot((1:length(xt_ALE)),xt_ALE)
title('Semnalul util din xtm dupa aplicarea algoritmului nLMS')
figure
plot((1:2*length(xm)-1),xcorr(xm))
title('Autocorelatia semnalului xm')

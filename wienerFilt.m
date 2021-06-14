function [xs_inv, hw] = wienerFilt(xsm, xs, LW)
N = LW + 1;

%calculul autocorelatiei semnalului xsm si a corelatiei dintre xsm si xs
Rx = xcorr(xsm);
Rdx = xcorr(xsm, xs);

%alegerea primelor N esantioane din fiecare semnal
Rx_N = Rx(1:N);
Rdx_N = Rdx(1:N);

%generarea matricei Toeplitz
Rxx_mat = toeplitz(Rx_N);

%calculul coeficientilor hw si filtrarea 
hw = inv(Rxx_mat)*Rdx_N;
xs_inv = filter(hw,1,xsm);
end
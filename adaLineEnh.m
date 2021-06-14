function xt_ALE = adaLineEnh(xtm,delta,mu,alpha,sigma,L)
%intarzierea cu delta esantioane
int = zeros(delta,1);
x = [int; xtm(1:(length(xtm)-delta))];

%initializarea lui b si a lui px cu 0
b = zeros(1,L+1);
px=0;

%aplicarea algoritmului nLMS
[xt_ALE,b,px] = nlms(x,xtm,b,mu,sigma,alpha,px);
end
function y = smMix(x1,x2,m_mix)
%repetarea semnalului xm astfel incat lungimea lui sa coincida cu
%lungimea lui xs
l = length(x1);
xd = zeros(l,1);
n = 1;
for i=1:l
    xd(i) = xd(i)+ x2(n);
    n = n + 1;
    if (n == length(x2) + 1)
        n = 1;
    end
end

%mixarea celor doua semnale
y = m_mix*x1 + (1 - m_mix)*xd;
end
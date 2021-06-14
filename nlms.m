function [y, b, px] = nlms(x, d, b, mu, sigma, alpha, px)
% USAGE:
%   [y, b, px] = nlms(x, d, b, mu, sigma, alpha, px)
% INPUTS:
%    x      = input data row vector [x(1),x(2),...,x(N)].
%    d      = desired signal row vector, same length as x.
%    b      = row vector with L+1 adaptive FIR weights. 
%             H(z)=b(1)+b(2)*z^(-1)+...+b(L+1)*z^(-L).
%    mu     = convergence parameter in the gen. eq.; scalar.
%    sigma  = estimate of x^2 (updated); scalar.
%    alpha  = forgetting factor in the gen. eq.; scalar.
%    px     = past values of x row vector (may be "0").
% OUTPUTS:  
%    y  = output row data vector with epsilon=d-y.
%    b  = updated adaptive weight row vector, length L+1.
%    px = updated px row vector; [x(N-1),...,x(N-L)].

Nx = length(x); Nd = length(d); Npx = length(px);
L = length(b)-1;

if Nx ~= Nd
    error('NLMS error: Lengths of x and d row vectors are not equal.');
elseif (mu <= 0 || mu >= 1)
    error('NLMS error: mu out of range.');
elseif (sigma <= 0)
    error('NLMS error: sigma out of range.');
elseif (alpha < 0 || alpha >= 1)
    error('NLMS error: alpha out of range.');
end

if Npx < L
    px = [px, zeros(1, L-Npx)];
end
px = [0, px];

y = zeros(1, Nx);
for k = 1:Nx
    px(1) = x(k);
    y(k) = b*px';
    if abs(y(k)) > 1e10,
        fprintf('\nNLMS warning: |y| output > 1e10.\n');
        y(k+1:Nx) = zeros(1, Nx-k);
        return
    end
    e = d(k) - y(k);
    sigma = alpha*(px(1)^2) + (1-alpha)*sigma;
    tmp = 2*mu/((L+1)*sigma);
    b = b + tmp*e*px;
    px(L+1:-1:2) = px(L:-1:1);
    if k == 1
        fprintf('--> Running NLMS; progress: 0%% ...\r')
    elseif k == floor(Nx/10)
        fprintf('--> Running NLMS; progress: 10%% ...\r')
    elseif k == floor(2*Nx/10)
        fprintf('--> Running NLMS; progress: 20%% ...\r')
    elseif k == floor(3*Nx/10)
        fprintf('--> Running NLMS; progress: 30%% ...\r')
    elseif k == floor(4*Nx/10)
        fprintf('--> Running NLMS; progress: 40%% ...\r')
    elseif k == floor(5*Nx/10)
        fprintf('--> Running NLMS; progress: 50%% ...\r')
    elseif k == floor(6*Nx/10)
        fprintf('--> Running NLMS; progress: 60%% ...\r')
    elseif k == floor(7*Nx/10)
        fprintf('--> Running NLMS; progress: 70%% ...\r')
    elseif k == floor(8*Nx/10)
        fprintf('--> Running NLMS; progress: 80%% ...\r')
    elseif k == floor(9*Nx/10)
        fprintf('--> Running NLMS; progress: 90%% ...\r')
    elseif k == floor(10*Nx/10)
        fprintf('--> Running NLMS; progress: 100%% ...\n')
    end
end

px = px(2:L+1);

end
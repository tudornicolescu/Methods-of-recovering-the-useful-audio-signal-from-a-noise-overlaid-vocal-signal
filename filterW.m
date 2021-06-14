function xt_inv = filterW(xtm,hw)
xt_inv = filter(hw,1,xtm);
end
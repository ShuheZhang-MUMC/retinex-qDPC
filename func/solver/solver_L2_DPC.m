function o_L2 = solver_L2_DPC(numer,denom,beta_L2,if_retinex)

%% L2-DPC
[m,n,~] = size(numer);
if if_retinex
    dx = [-1,1];    otf_dx = psf2otf(dx,[m,n]);
    dy = [-1;1];    otf_dy = psf2otf(dy,[m,n]);
    NTN = abs(otf_dx).^2 + abs(otf_dy).^2;
else
    NTN = 1;
end

o_L2 = real(ifft2(numer .* NTN./(denom .* NTN + beta_L2)));
end
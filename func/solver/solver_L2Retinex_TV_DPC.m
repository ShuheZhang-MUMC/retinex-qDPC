function o_TV = solver_L2Retinex_TV_DPC(numer,denom,beta_TV,iter,...
                                                            if_retinex)

%% Total variation regularization DPC

o = real(ifft2(numer./(denom + 1e-6)));

dx = [0,-1,1];    otf_dx = psf2otf(dx,size(o));
dy = [0;-1;1];    otf_dy = psf2otf(dy,size(o));
DTD = abs(otf_dx).^2 + abs(otf_dy).^2;

if if_retinex
    NTN = DTD;
else
    NTN = 1;
end

gx = 0;
gy = 0;
bx = 0;
by = 0;

for loop = 1:iter
    clc
    disp('TV-DPC solver, deconvolution:')
    disp([num2str(round(loop/iter * 100)),'%'])
    
    %% o sub-problem
    Gx = fft2(imfilter(gx + bx,dx,'circular'));
    Gy = fft2(imfilter(gy + by,dy,'circular'));

    fenzi = numer .* NTN + (Gx + Gy);
    fenmu = denom .* NTN + DTD + 1e-6;
    fft_o = fenzi./fenmu;
    o = real(ifft2(fft_o));
    
    %% g sub-problem
    temp_gx = imfilter(o,dx,'circular','conv');
    temp_gy = imfilter(o,dy,'circular','conv');

    gx = sign(temp_gx - bx) .* max(abs(temp_gx - bx) - beta_TV,0);
    gy = sign(temp_gy - by) .* max(abs(temp_gy - by) - beta_TV,0);
   
    bx = bx + gx - temp_gx;
    by = by + gy - temp_gy;
end

o_TV = o;


end
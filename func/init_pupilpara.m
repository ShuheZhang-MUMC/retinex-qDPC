H_ph = zeros(pic(1),pic(2),num_dpc);
H_ab = zeros(pic(1),pic(2),num_dpc);
% 
Ft = @(x) fft2(x);
iFt = @(x) ifft2(x);


numer = 0;
denom = 0;
for dpc = 1:2
    S = S0.*mask_dpc(:,:,dpc);
    FSP = conj(Ft(S.*pupil)).*Ft(pupil);
    
    H_ab_0 =  2*iFt(real(FSP));
    H_ph_0 = -2*iFt(imag(FSP));
    
    Htot = sqrt(abs(H_ab_0).^2+abs(H_ph_0).^2);
    Htotmax = max(max(Htot));
    H_ab(:,:,dpc) = H_ab_0./Htotmax;
    H_ph(:,:,dpc) = H_ph_0./Htotmax;
    
    numer = numer + Ft(img_dpc(:,:,dpc)).*conj(H_ph(:,:,dpc));
    denom = denom + abs(H_ph(:,:,dpc)).^2;
end
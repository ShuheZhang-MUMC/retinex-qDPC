%% 
scale = unit / mag;     

pic = size(img1);

x_len = pic(2) * scale;
y_len = pic(1) * scale;

x = linspace(-x_len/2,x_len/2,pic(2));
y = linspace(-y_len/2,y_len/2,pic(1));
[x,y] = meshgrid(x,y);


fx = (-pic(2)/2:pic(2)/2-1)/x_len; 
fy = (-pic(1)/2:pic(1)/2-1)/y_len; 
[Fx, Fy]   = meshgrid(fx, fy);
pupil = sqrt(Fx.^2 + Fy.^2) < (na_obj/lambda);


otf_dx = psf2otf([1,-2,1],size(img1));
otf_dy = psf2otf([1;-2;1],size(img1));
otf_dz = psf2otf([-1,1;1,-1],size(img1));

sss = (img1 + img2 + img3 + img4)/2;

img_dpc(:,:,1) = (img1 - img2)./(sss + eps);
img_dpc(:,:,2) = (img3 - img4)./(sss + eps);

imwrite(mat2gray(abs(img_dpc(:,:,1))),'sample_dpc.png')
S0 = ((sqrt(Fx.^2+Fy.^2) < (na_illum/lambda))) .* ...
     ((sqrt(Fx.^2+Fy.^2) > (na_inner*na_illum/lambda)));  

mask_dpc(:,:,1) = -sign(Fy);
mask_dpc(:,:,2) = -sign(Fx);




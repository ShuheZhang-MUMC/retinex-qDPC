clc
clear

tic


%% data loading
illu_rotation = [90, 270, 0, 180];
img1 = mean(double(imread('rawdata//r1.bmp'))/255,3);
img2 = mean(double(imread('rawdata//r2.bmp'))/255,3);
img3 = mean(double(imread('rawdata//r3.bmp'))/255,3);
img4 = mean(double(imread('rawdata//r4.bmp'))/255,3);


[m,n] = size(img1);
img1 = img1(10:end,:);
img2 = img2(10:end,:);
img3 = img3(10:end,:);
img4 = img4(10:end,:);

img_BF = (img1+img2+img3+img4)/4; 
imwrite(mat2gray(img_BF),'bf.png')


%% computation
addpath(genpath('func//'));
disp('initializing environment');init_environment;
disp('initializing computing parameters');init_computation;
disp('initializing pupil parameters');init_pupilpara;

%% solving

lambda_l2 = 0.0001;
lambda_tv = 0.008;
iter = 30;
if_retinex = true;

% if_retinex = false, performing dpc deconvolution with only
% total-variation regularization

o_L2 = solver_L2_DPC(numer,denom,lambda_l2,false);
o_Re = solver_L2Retinex_TV_DPC(numer,denom,...
                                     lambda_tv,...
                                     iter,...
                                     if_retinex); 

figure();imshow(o_L2,[])
figure();imshow(o_Re,[])

rmpath(genpath('func//'))







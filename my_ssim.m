%%%SSIMº¯ÊýÊµÏÖ
function ssim_val = my_ssim(img1, img2)

% Convert the images to double precision
img1 = im2double(img1);
img2 = im2double(img2);

% Constants for SSIM calculation
K1 = 0.01;
K2 = 0.03;
L = 1;
C1 = (K1*L)^2;
C2 = (K2*L)^2;

% Mean values of the two images
mu1 = mean2(img1);
mu2 = mean2(img2);

% Variances of the two images
sigma1_sq = var(img1(:));
sigma2_sq = var(img2(:));

% Covariance between the two images
sigma12 = cov(img1(:), img2(:));

% Calculate SSIM
num = (2*mu1*mu2 + C1) * (2*sigma12 + C2);
den = (mu1^2 + mu2^2 + C1) * (sigma1_sq + sigma2_sq + C2);
ssim_val = num / den;

%Avarvge
ssim_val = mean(ssim_val);
ssim_val = mean(ssim_val);

end

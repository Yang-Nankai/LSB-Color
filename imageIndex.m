%%%%MSE、PSNR、SSIM评价指标

% 读取载体图像和原始图像
carrier = imread('./output/orignalImg.bmp');
original = imread('./output/stegoImg.bmp');

% 计算MES
mes = sum(sum(sum((carrier - original).^2))) / (size(carrier, 1) * size(carrier, 2) * size(carrier, 3));

% 计算PSNR
psnr = 10 * log10(255^2 / mes);

% 计算SSIM
ssimval = my_ssim(carrier, original);

% 输出结果
fprintf('MES: %f\n', mes);
fprintf('PSNR: %f dB\n', psnr);
fprintf('SSIM: %f\n', ssimval);

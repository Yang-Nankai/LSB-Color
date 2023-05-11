%%%%MSE��PSNR��SSIM����ָ��

% ��ȡ����ͼ���ԭʼͼ��
carrier = imread('./output/orignalImg.bmp');
original = imread('./output/stegoImg.bmp');

% ����MES
mes = sum(sum(sum((carrier - original).^2))) / (size(carrier, 1) * size(carrier, 2) * size(carrier, 3));

% ����PSNR
psnr = 10 * log10(255^2 / mes);

% ����SSIM
ssimval = my_ssim(carrier, original);

% ������
fprintf('MES: %f\n', mes);
fprintf('PSNR: %f dB\n', psnr);
fprintf('SSIM: %f\n', ssimval);

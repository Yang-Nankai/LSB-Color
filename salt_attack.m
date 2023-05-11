%%%%%%%%%%%%%%%%%%%%椒盐噪声
% 读取原始图像
img = imread('./output/stegoImg.bmp');

% 设置椒盐噪声的密度（即噪声像素所占的比例）
density = 0.3;

% 生成随机的噪声像素位置
noise_pixels = rand(size(img, 1), size(img, 2));
noise_pixels = noise_pixels < density/2 | noise_pixels > 1-density/2;

% 将随机位置的像素设置为黑色或白色
noise = uint8(255 * (rand(size(img)) > 0.5));
noise(noise == 255) = 1;
noise(noise_pixels) = 0;

% 将原始图像和噪声图像合并
noisy_img = img;
noisy_img(noise_pixels) = noise(noise_pixels);

% 显示噪声图像
imwrite(noisy_img, './Test/noisy_img.bmp', 'bmp')
imshow(noisy_img);
title('椒盐噪声后的载体图像');

%然后对处理后的图像进行解密
key = 123456;
m = extractLSB_RGB(noisy_img,512,512,key,1,2,10,3.769947,0.75,50);

%%%%%%%%%%%%%%%%%%%%椒盐噪声
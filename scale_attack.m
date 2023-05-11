%%This file is used to attack the alogirthm

%%%%%%%%%%%%%%%%%%%%尺度变换攻击
% 读取原始图像
img = imread('./output/stegoImg.bmp');

% 对彩色载体图像进行 2 倍插值
img = imresize(img, 2, 'bicubic');

% 对插值后的图像进行 2 倍下采样
img = imresize(img, 0.5, 'bicubic');

% % 缩小为原图尺寸
% img = imresize(img, size(img)/2, 'bicubic');

% 显示变换后的图像
imwrite(img, './Test/scale_stegoimg.bmp', 'bmp')
imshow(img);
title('变换后的载体图像');

%然后对裁剪后的图像进行解密
key = 123456;
m = extractLSB_RGB(img,512,512,key,1,2,10,3.769947,0.75,50);

%%%%%%%%%%%%%%%%%%%%裁剪攻击

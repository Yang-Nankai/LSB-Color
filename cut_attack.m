%%This file is used to attack the alogirthm

%%%%%%%%%%%%%%%%%%%%裁剪攻击
% 读取原始图像
img = imread('./output/stegoImg.bmp');

% 设置裁剪区域的起始坐标和宽度、高度
x = 100;
y = 100;
w = 500;
h = 500;

% 将裁剪区域之内的部分设置为黑色
img(y:y+h-1, x:x+w-1, :) = 0;

% 显示裁剪后的图像
imwrite(img, './Test/cut_stegoimg.bmp', 'bmp')
imshow(img);
title('裁剪后的载体图像');

%然后对裁剪后的图像进行解密
key = 123456;
m = extractLSB_RGB(img,512,512,key,1,2,10,3.769947,0.75,50);

%%%%%%%%%%%%%%%%%%%%裁剪攻击

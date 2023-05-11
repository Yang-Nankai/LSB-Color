%%This file is used to attack the alogirthm

%%%%%%%%%%%%%%%%%%%%涂抹攻击
% 读取原始图像
img = imread('./output/stegoImg.bmp');

% 设置不规则形状涂抹区域的坐标点
x = [100 150 200 250 300 350 400 450];
y = [100 150 200 250 300 250 200 150];

% 创建一个二值化的遮罩，表示不规则形状
mask = poly2mask(x, y, size(img, 1), size(img, 2));

% 将不规则形状区域内的部分设置为黑色
img(repmat(mask, [1, 1, size(img, 3)])) = 0;

% 显示涂抹后的图像
imwrite(img, './Test/smear_stegoimg.bmp', 'bmp')
imshow(img);
title('涂抹后的载体图像');

%然后对涂抹后的图像进行解密
key = 123456;
m = extractLSB_RGB(img,512,512,key,1,2,10,3.769947,0.75,50);

%%%%%%%%%%%%%%%%%%%%涂抹攻击

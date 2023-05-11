%--------------------------------------------------------------------------
% FILE:         extractLSB_RGB.m
% AUTHOR:       [YangXin]
% DATE:         [2023-05-10]
% DESCRIPTION:  Extract RGB image through the new RGB-LSB method
%
% INPUTS:
%   coverImg: the input covered image
%   h: the secret image height
%   w: the secret image width
%   key: the key
%   a: the arnold paramter
%   b: the arnold paramter
%   iterA: the arnold paramter
%   r: the logistic paramter
%   x: the logistic paramter
%   iterB: the logistic paramter
%
% OUTPUTS:
%   secretImg: the secret image
%
% NOTES:        This function is compatible with MATLAB R2013a.
%--------------------------------------------------------------------------
function secretImg = extractLSB_RGB(coverImg, h, w, key, a, b, iterA, r, x, iterB)
if nargin < 10, iterB = 50; end
if nargin < 9, x = 0.75; end
if nargin < 8, r = 3.769947; end
if nargin < 7, iterA = 10; end
if nargin < 6, b = 2; end
if nargin < 5, a = 1; end

% 获取图像大小及待嵌入图像大小
[m, n, ~] = size(coverImg);

coverImg = im2uint8(coverImg);

% 获取随机序列 xkey 和 ykey
key = int32(key);

rng(key);
xkey = randperm(m, h);
ykey = randperm(n, w);

% 分离RGB图像的三个通道
R_Vec = coverImg(:,:,1);
G_Vec = coverImg(:,:,2);
B_Vec = coverImg(:,:,3);

wme_8 = zeros(h,w);
wme_7 = zeros(h,w);
wme_6 = zeros(h,w);
wme_5 = zeros(h,w);
wme_4 = zeros(h,w);
wme_3 = zeros(h,w);
wme_2 = zeros(h,w);
wme_1 = zeros(h,w);

% 得到加密的随机序列
for i=1:h
    for j=1:w
        wme_8(i,j)=bitget(R_Vec(xkey(i),ykey(j)), 4);
        wme_5(i,j)=bitget(R_Vec(xkey(i),ykey(j)), 3);
        wme_7(i,j)=bitget(G_Vec(xkey(i),ykey(j)), 4);
        wme_4(i,j)=bitget(G_Vec(xkey(i),ykey(j)), 3);
        wme_6(i,j)=bitget(B_Vec(xkey(i),ykey(j)), 4);
        wme_3(i,j)=bitget(B_Vec(xkey(i),ykey(j)), 3);
        wme_2(i,j)=bitget(B_Vec(xkey(i),ykey(j)), 2);
        wme_1(i,j)=bitget(B_Vec(xkey(i),ykey(j)), 1);
    end
end


% 将得到的位平面组合起来
% 将每个位平面左移相应的位数
img_1 = uint8(bitshift(wme_8, 7));
img_2 = uint8(bitshift(wme_7, 6));
img_3 = uint8(bitshift(wme_6, 5));
img_4 = uint8(bitshift(wme_5, 4));
img_5 = uint8(bitshift(wme_4, 3));
img_6 = uint8(bitshift(wme_3, 2));
img_7 = uint8(bitshift(wme_2, 1));
img_8 = uint8(wme_1);

% 使用 bitor 函数将所有的位平面组合成一个矩阵
secretImg = bitor(bitor(bitor(bitor(bitor(bitor(bitor(img_1, img_2), img_3), img_4), img_5), img_6), img_7), img_8);

%对图像进行Arnold置换解密与Logistic混沌解密
secretImg = logistic_decrypt(secretImg, r, x, iterB);
secretImg = unarnold_image(secretImg, a, b, iterA);

imwrite(secretImg, './output/decrypt_secret.bmp', 'bmp');
figure
imshow(secretImg,[])
title('decrypt_secret');

end
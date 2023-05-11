%--------------------------------------------------------------------------
% FILE:         embedLSB_RGB.m
% AUTHOR:       [YangXin]
% DATE:         [2023-05-10]
% DESCRIPTION:  Embed RGB image through the new RGB-LSB method
%
% INPUTS:
%   coverImg: the input covered image
%   secretImg: the input secret image
%   key: the key
%   a: the arnold paramter
%   b: the arnold paramter
%   iterA: the arnold paramter
%   r: the logistic paramter
%   x: the logistic paramter
%   iterB: the logistic paramter
%
% OUTPUTS:
%   stegoImg: the stego image
%
% NOTES:        This function is compatible with MATLAB R2013a.
%--------------------------------------------------------------------------
function stegoImg = embedLSB_RGB(coverImg, secretImg, key, a, b, iterA, r, x, iterB)
if nargin < 9, iterB = 50; end
if nargin < 8, x = 0.75; end
if nargin < 7, r = 3.769947; end
if nargin < 6, iterA = 10; end
if nargin < 5, b = 2; end
if nargin < 4, a = 1; end

% ��ȡͼ���С����Ƕ��ͼ���С
[m, n, ~] = size(coverImg);
[h, w, ~] = size(secretImg);

coverImg = im2uint8(coverImg);
secretImg = im2uint8(secretImg);

%��ͼ�����Arnold�û���Logistic�������
secretImg = arnold_image(secretImg, a, b, iterA);
secretImg = logistic_encrypt(secretImg, r, x, iterB);

% ��ȡ������� xkey �� ykey
key = int32(key);

rng(key);
xkey = randperm(m, h);
ykey = randperm(n, w);

% ����RGBͼ�������ͨ��
R_Vec = coverImg(:,:,1);
G_Vec = coverImg(:,:,2);
B_Vec = coverImg(:,:,3);

% ��ˮӡͼ��ֽ�Ϊ8��λƽ��
wm_1 = bitget(secretImg, 1);
wm_2 = bitget(secretImg, 2);
wm_3 = bitget(secretImg, 3);
wm_4 = bitget(secretImg, 4);
wm_5 = bitget(secretImg, 5);
wm_6 = bitget(secretImg, 6);
wm_7 = bitget(secretImg, 7);
wm_8 = bitget(secretImg, 8);

% ѭ��������ͼ�����������Ƕ�뵽��ɫͼ����
for i=1:h
    for j=1:w
        R_Vec(xkey(i),ykey(j)) = bitset(R_Vec(xkey(i),ykey(j)), 4, wm_8(i,j));
        R_Vec(xkey(i),ykey(j)) = bitset(R_Vec(xkey(i),ykey(j)), 3, wm_5(i,j));
        G_Vec(xkey(i),ykey(j)) = bitset(G_Vec(xkey(i),ykey(j)), 4, wm_7(i,j));
        G_Vec(xkey(i),ykey(j)) = bitset(G_Vec(xkey(i),ykey(j)), 3, wm_4(i,j));
        B_Vec(xkey(i),ykey(j)) = bitset(B_Vec(xkey(i),ykey(j)), 4, wm_6(i,j));
        B_Vec(xkey(i),ykey(j)) = bitset(B_Vec(xkey(i),ykey(j)), 3, wm_3(i,j));
        B_Vec(xkey(i),ykey(j)) = bitset(B_Vec(xkey(i),ykey(j)), 2, wm_2(i,j));
        B_Vec(xkey(i),ykey(j)) = bitset(B_Vec(xkey(i),ykey(j)), 1, wm_1(i,j));
    end
end

% ��Ƕ����Ϣ���������ת��Ϊ RGB ��ɫͼ�����
stegoImg = cat(3,R_Vec,G_Vec,B_Vec);
imwrite(stegoImg, './output/stegoImg.bmp', 'bmp');
figure
imshow(stegoImg,[])
title('stegoImg');
end